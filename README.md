# README

Below are the answers for the questions asked in the assignment:

1. To ensure that the cache is efficient but also up to date, we could set an expiration time for the cached data to expire the cache after 1 hour, for example. We could also implement cache invalidation by using Redis pub/sub or by manually invalidating the cache when new data is available.
2. Another way of improving the service's performance is to also cache requests for characters, for even faster character retrieval. This should also be configured with an expiration time for the cached data, or some cache invalidation mechanism.
3. One upside of this implementations is that it reduces the ammount of requests to the Rick and Morty API. A couple of downsides are the added complexity to the code and the possibility of stale data in the cache.
