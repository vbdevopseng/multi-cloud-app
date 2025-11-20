import app


def test_index_returns_200():
    client = app.app.test_client()
    resp = client.get('/')
    assert resp.status_code == 200
    data = resp.get_json()
    assert data['message'].startswith('Hello')