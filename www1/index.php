<?php
date_default_timezone_set('Asia/Tokyo');

// APIのURL
$url = 'http://10.1.0.156/data';

// cURLセッションを初期化
$ch = curl_init($url);

// オプションを設定
curl_setopt($ch, CURLOPT_RETURNTRANSFER, true); // 結果を文字列として返す
curl_setopt($ch, CURLOPT_HTTPHEADER, [
    'Accept: application/json',
    'Authorization: Bearer YOUR_ACCESS_TOKEN' // 認証が必要な場合
]);

// APIを呼び出す
$response = curl_exec($ch);

// エラーチェック
if (curl_errno($ch)) {
    echo 'エラー: ' . curl_error($ch);
} else {
    // 結果を表示
    $data = json_decode($response, true);
    print_r($data);
}

// セッションを閉じる
curl_close($ch);
?>