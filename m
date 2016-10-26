References: <784d3a54-24a9-dc57-b1f3-a8010d7e99db@...277...>
	<20161006121736.GB78279@...1296...>
	<50515770-ae2b-ee70-9ada-452f69cce800@...1227...>
	<a24673c2-2aca-7bcb-6826-23335bf5a557@...277...>
	<6ccb18ab-8434-6433-8f21-aabc4459955e@...277...>
	<20161006170142.GD78279@...1296...>
From: debbie10t <debbie10t@...277...>
Message-ID: <5ce37111-0757-2072-8032-358f1728f44b@...277...>
Date: Wed, 26 Oct 2016 20:18:47 +0100
MIME-Version: 1.0
In-Reply-To: <20161006170142.GD78279@...1296...>
Subject: Re: [Openvpn-devel] Slight change to buildbot t_client.sh.in &
 t_client.rc
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>



On 06/10/16 18:01, Gert Doering wrote:
> Hi,
>
> On Thu, Oct 06, 2016 at 04:47:21PM +0100, debbie10t wrote:
>> As I am on possibly the cheapest internet in the UK and "-i 1000"
>> solves the problem, i expect simply including say "-i 2000" in
>> t_client.sh.in will be sufficient for just about anywhere, unless
>> you try to run a buildslave in the jungles of Borneo !
>
> To repeat this: *no*.  We're not including -i 2000 by default in the
> script, because that will slow down things for all testers (and t_client
> takes enough time as it is, I run it interactively often enough).
>
> gert
>

Sorry to drag this up again ...

I have done a little more testing and simply adding -i 100 allows fping
to succeed on my buildbots.  (more or less, some pings fail but target
is alive)

Also note; over 60 pings (my tests) this adds about one second,
so for 20 pings (t_client) this will add ~300ms per fping test.

These timings are very approximate because using -c 20 -p 250 -i 50
ran faster than -c 20 -p 250 -i 25 by ~300ms, see last tests attached.

Regards


==


TESTS:


Running three bots *concurrently* (arch-64, cos7-64, gtoo-64):

-i 25 (default):


[root@...2174... t_client-arch-hyv-live-64-20161020-005508]# fping 
-b 3000 -s -r 1 -q -C 60 -p 250 -i 25 10.194.6.1 10.194.0.1
10.194.6.1 : 204.64 205.65 205.11 204.47 204.49 205.04 204.96 204.23 - - 
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
- - - - - - - - - - - - - -
10.194.0.1 : - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

        2 targets
        1 alive
        1 unreachable
        0 unknown addresses

        2 timeouts (waiting for response)
      120 ICMP Echos sent
        8 ICMP Echo Replies received
        0 other ICMP received

  204 ms (min round trip time)
  204 ms (avg round trip time)
  205 ms (max round trip time)
        15.324 sec (elapsed real time)


[root@...2188... t_client-cos7-hyv-live-64-20161019-222647]# fping 
-b 3000 -s -q -C 60 -p 250 -i 25 10.194.6.1 10.194.0.1
10.194.6.1 : - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
- - - - - - - - - - - - - - - - - - - - - - - - - - - 214.32 215.88 215.79
10.194.0.1 : - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

        2 targets
        1 alive
        1 unreachable
        0 unknown addresses

        2 timeouts (waiting for response)
      120 ICMP Echos sent
        3 ICMP Echo Replies received
        0 other ICMP received

  214 ms (min round trip time)
  215 ms (avg round trip time)
  215 ms (max round trip time)
        15.327 sec (elapsed real time)


gtoo-hyv-live-64 t_client-gtoo-hyv-live-64-20161019-222726 # fping -b 
3000 -s -q -C 60 -p 250 -i 25 10.194.6.1 10.194.0.1
10.194.6.1 : 205.06 205.26 205.79 205.57 205.03 205.29 204.92 204.79 
204.51 204.89 204.12 204.78 204.88 204.79 204.58 205.15 205.10 204.93 
204.77 204.66 205.27 204.27 204.85 204.66 205.43 204.59 205.63 204.46 
205.32 204.04 205.40 204.27 204.62 205.00 204.90 205.14 206.55 207.66 
204.72 204.46 204.78 204.69 204.29 204.57 205.09 204.39 204.53 205.44 
205.19 204.67 205.22 205.45 205.07 204.23 204.93 204.82 205.74 204.43 
205.31 204.69
10.194.0.1 : - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

        2 targets
        1 alive
        1 unreachable
        0 unknown addresses

        1 timeouts (waiting for response)
      120 ICMP Echos sent
       60 ICMP Echo Replies received
        0 other ICMP received

  204 ms (min round trip time)
  204 ms (avg round trip time)
  207 ms (max round trip time)
        15.316 sec (elapsed real time)




***** Verses *****




Running three bots *concurrently* (arch-64, cos7-64, gtoo-64):

-i 100


[root@...2174... t_client-arch-hyv-live-64-20161020-005508]# fping 
-b 3000 -s -r 1 -q -C 60 -p 250 -i 100 10.194.6.1 10.194.0.1
10.194.6.1 : 204.55 206.03 205.79 204.62 205.60 222.08 221.34 221.46 
222.40 222.19 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
- - - - - - - - - - - - - - - - - - - - -
10.194.0.1 : 205.62 204.56 204.32 204.40 204.01 205.02 204.73 205.06 
205.11 204.53 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
- - - - - - - - - - - - - - - - - - - - -

        2 targets
        2 alive
        0 unreachable
        0 unknown addresses

        2 timeouts (waiting for response)
      120 ICMP Echos sent
       20 ICMP Echo Replies received
        0 other ICMP received

  204 ms (min round trip time)
  209 ms (avg round trip time)
  222 ms (max round trip time)
        15.471 sec (elapsed real time)


[root@...2188... t_client-cos7-hyv-live-64-20161019-222647]# fping 
-b 3000 -s -q -C 60 -p 250 -i 100 10.194.6.1 10.194.0.1
10.194.6.1 : - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
- - - - - - - - - - - - - - - - - - - - - - - - - - 228.89 229.47 230.52 
229.64
10.194.0.1 : 205.87 205.88 204.70 204.63 204.46 205.46 205.34 204.66 
205.24 204.88 205.11 205.04 205.17 204.48 204.32 204.99 204.99 205.32 
204.74 205.22 204.55 205.72 204.82 204.75 205.14 204.45 204.90 204.53 
205.28 205.63 205.53 210.77 204.66 205.23 205.86 205.06 204.45 205.79 
206.04 205.35 204.60 204.35 204.79 204.68 204.98 205.35 205.00 204.95 
205.11 205.35 205.07 204.63 205.48 205.88 204.98 204.58 205.32 205.42 
204.12 205.40

        2 targets
        2 alive
        0 unreachable
        0 unknown addresses

        1 timeouts (waiting for response)
      120 ICMP Echos sent
       64 ICMP Echo Replies received
        0 other ICMP received

  204 ms (min round trip time)
  206 ms (avg round trip time)
  230 ms (max round trip time)
        15.370 sec (elapsed real time)


gtoo-hyv-live-64 t_client-gtoo-hyv-live-64-20161019-222726 # fping -b 
3000 -s -q -C 60 -p 250 -i 100 10.194.6.1 10.194.0.1
10.194.6.1 : - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
- - - - - - - - - - - - - - - - - - - - - - - - - 204.17 204.77 204.83 
205.03 204.53
10.194.0.1 : 221.57 227.55 227.60 226.33 226.41 225.89 229.20 227.19 
218.36 225.55 228.86 226.33 228.87 225.60 226.15 225.72 - 231.33 232.21 
232.04 232.50 231.78 233.23 235.11 233.05 233.56 231.19 231.98 232.96 
228.11 229.75 231.37 232.44 232.62 232.50 - - 233.19 232.10 - - 231.78 
232.69 231.57 - - 232.37 232.10 233.15 - 204.91 205.40 204.86 205.13 
204.39 205.20 205.00 204.64 205.15 204.55

        2 targets
        2 alive
        0 unreachable
        0 unknown addresses

        2 timeouts (waiting for response)
      120 ICMP Echos sent
       57 ICMP Echo Replies received
        0 other ICMP received

  204 ms (min round trip time)
  223 ms (avg round trip time)
  235 ms (max round trip time)
        15.469 sec (elapsed real time)





***** Weird Test *****





-i 25 vs -i 50


[root@...2174... t_client-arch-hyv-live-64-20161020-005508]# fping 
-b 3000 -s -r 1 -q -C 20 -p 250 -i 25 10.194.6.1 10.194.0.1
10.194.6.1 : 204.93 205.16 205.67 204.48 210.17 206.68 205.02 204.31 
204.46 204.85 205.16 205.37 204.53 204.87 204.68 204.62 204.52 204.19 
204.76 204.62
10.194.0.1 : - - - - - - - - - - - - - - - - - - - -

        2 targets
        1 alive
        1 unreachable
        0 unknown addresses

        1 timeouts (waiting for response)
       40 ICMP Echos sent
       20 ICMP Echo Replies received
        0 other ICMP received

  204 ms (min round trip time)
  205 ms (avg round trip time)
  210 ms (max round trip time)
         5.306 sec (elapsed real time)

[root@...2174... t_client-arch-hyv-live-64-20161020-005508]# fping 
-b 3000 -s -r 1 -q -C 20 -p 250 -i 50 10.194.6.1 10.194.0.1
10.194.6.1 : 205.43 205.04 205.78 205.02 204.64 204.97 205.59 208.24 
205.14 204.61 204.40 205.01 205.86 205.22 204.34 204.51 205.10 204.31 
204.41 205.40
10.194.0.1 : 217.68 217.27 216.52 216.55 216.54 216.77 219.69 216.99 
218.59 218.32 216.42 217.08 216.88 217.50 216.55 217.05 216.13 216.45 
216.08 216.36

        2 targets
        2 alive
        0 unreachable
        0 unknown addresses

        0 timeouts (waiting for response)
       40 ICMP Echos sent
       40 ICMP Echo Replies received
        0 other ICMP received

  204 ms (min round trip time)
  211 ms (avg round trip time)
  219 ms (max round trip time)
         5.017 sec (elapsed real time)

==

The decision is yours ..


