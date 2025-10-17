<?php

namespace App\Services;

use Google\Cloud\Firestore\FirestoreClient;

class FirestoreService
{
    protected $db;

    public function __construct()
    {
        $keyFile = json_decode(file_get_contents(
            storage_path('firebase/firebase_credentials.json')
        ), true);

        $this->db = new FirestoreClient([
            'keyFile' => $keyFile,
            'projectId' => 'rideon-1a627',
            'transport' => 'rest',
            'apiEndpoint' => 'firestore.googleapis.com',
        ]);

    }

    public function getCollection(string $collection)
    {
        return $this->db->collection($collection)->documents();
    }

    public function addDocument(string $collection, array $data)
    {
        return $this->db->collection($collection)->add($data);
    }

    public function updateDocument(string $collection, string $documentId, array $data)
    {
        return $this->db->collection($collection)
            ->document($documentId)
            ->update(
                array_map(fn ($k, $v) => ['path' => $k, 'value' => $v], array_keys($data), $data)
            );
    }

    public function deleteDocument(string $collection, string $documentId): void
    {
        $this->db->collection($collection)
            ->document($documentId)
            ->delete();
    }

    public function getDocument(string $collection, string $documentId): ?array
    {
        $snapshot = $this->db->collection($collection)->document($documentId)->snapshot();

        return $snapshot->exists() ? $snapshot->data() : null;
    }
}
