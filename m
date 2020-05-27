Date: Wed, 27 May 2020 08:11:39 -0700
From: Jeremy Evans <code@...2557...>
Message-ID: <20200527151139.GC49848@...2558...>
References: <20200520183404.54822-1-code@...2557...>
 <20200520193344.GQ1431@...1296...>
 <20200520213104.GS23489@...2558...>
 <E1jdvnM-0000uH-RB@...2479...>
MIME-Version: 1.0
In-Reply-To: <E1jdvnM-0000uH-RB@...2479...>
Subject: Re: [Openvpn-devel] [PATCH] Switch assertion failure to returning
 false
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: Steffan Karger <steffan.karger@...2507...>
Cc: openvpn-devel@lists.sourceforge.net

On 05/27 03:08, Steffan Karger wrote:
> Hi,
> 
> Thanks for the clear report, patch and follow-up.
> 
> On 20-05-2020 23:31, Jeremy Evans wrote:
> > On 05/20 09:33, Gert Doering wrote:
> >> On Wed, May 20, 2020 at 11:34:04AM -0700, Jeremy Evans wrote:
> >>> To give some background, we hit this assertion failure, with the
> >>> following log output:
> >>
> >> This should not happen, asserting out in "normal server use" is bad.  
> >>
> >> (Neither should it ever reach that point without ks->authenticated being 
> >> true)
> 
> Agreed. I think it makes sense to first fix the urgent part (ie, not
> kill the server), then figure out how de code ends up at this ASSERT.
> 
> Jeremy, can you determine from your logs whether this always
> happenedwhen --auth-user-pass-verify returns zero or non-zero? Ie,
> should the connections that trigger this succeed or fail?

--auth-user-pass-verify returned non-zero in each crash.  In that sense,
the assert was good, because the alternative would be that an
unauthenticated user may be able to get VPN access (assuming there
wasn't some later check that caught the issue).

Here are the relevant log sections from the 4 crashes:

Tue May 19 15:57:03 2020 username/73.135.141.11:1194 WARNING: Failed running command (--auth-user-pass-verify): external program exited with error status: 1
Tue May 19 15:57:03 2020 username/73.135.141.11:1194 TLS Auth Error: Auth Username/Password verification failed for peer
Tue May 19 15:57:03 2020 username/73.135.141.11:1194 Control Channel: TLSv1.2, cipher TLSv1/SSLv3 ECDHE-RSA-AES256-GCM-SHA384, 2048 bit RSA
Tue May 19 15:57:04 2020 username1/73.112.148.11:1194 TLS: new session incoming connection from [AF_INET]73.112.148.11:1194
Tue May 19 15:57:04 2020 username2/73.190.61.11:1194 TLS: new session incoming connection from [AF_INET]73.190.61.11:1194
Tue May 19 15:57:04 2020 username3/73.190.134.11:1194 TLS: new session incoming connection from [AF_INET]73.190.134.11:1194
Tue May 19 15:57:04 2020 username4/73.120.76.11:1194 TLS: new session incoming connection from [AF_INET]73.120.76.11:1194
Tue May 19 15:57:05 2020 username5/73.16.123.11:1194 TLS: new session incoming connection from [AF_INET]73.16.123.11:1194
Tue May 19 15:57:05 2020 username/73.135.141.11:1194 PUSH: Received control message: 'PUSH_REQUEST'
Tue May 19 15:57:05 2020 username/73.135.141.11:1194 SENT CONTROL [username]: 'PUSH_REPLY,redirect-gateway def1,comp-lzo,persist-key,persist-tun,route-gateway 10.28.47.1,topology subnet,ping 10,ping-restart 120,ifconfig 10.28.47.38 255.255.255.0,peer-id 89' (status=1)
Tue May 19 15:57:05 2020 username/73.135.141.11:1194 Assertion failed at /path/to/openvpn-2.4.7/src/openvpn/ssl.c:1944 (ks->authenticated)

Wed May 13 14:14:54 2020 username/24.106.43.11:1194 WARNING: Failed running command (--auth-user-pass-verify): external program exited with error status: 1
Wed May 13 14:14:54 2020 username/24.106.43.11:1194 TLS Auth Error: Auth Username/Password verification failed for peer
Wed May 13 14:14:54 2020 username/24.106.43.11:1194 TLS: move_session: dest=TM_ACTIVE src=TM_UNTRUSTED reinit_src=1
Wed May 13 14:14:54 2020 username/24.106.43.11:1194 TLS: tls_multi_process: untrusted session promoted to semi-trusted
Wed May 13 14:14:54 2020 username/24.106.43.11:1194 Control Channel: TLSv1.2, cipher TLSv1/SSLv3 ECDHE-RSA-AES256-GCM-SHA384, 2048 bit RSA
Wed May 13 14:14:57 2020 username/24.106.43.11:1194 PUSH: Received control message: 'PUSH_REQUEST'
Wed May 13 14:14:57 2020 username/24.106.43.11:1194 SENT CONTROL [username]: 'PUSH_REPLY,redirect-gateway def1,comp-lzo,persist-key,persist-tun,route-gateway 10.28.47.1,topology subnet,ping 10,ping-restart 120,ifconfig 10.28.47.38 255.255.255.0,peer-id 89' (status=1)
Wed May 13 14:14:57 2020 username/24.106.43.11:1194 Assertion failed at /path/to/openvpn-2.4.7/src/openvpn/ssl.c:1944 (ks->authenticated)

Wed Sep 25 12:14:56 2019 username/174.94.150.11:30407 WARNING: Failed running command (--auth-user-pass-verify): external program exited with error status: 1
Wed Sep 25 12:14:56 2019 username/174.94.150.11:30407 TLS Auth Error: Auth Username/Password verification failed for peer
Wed Sep 25 12:14:56 2019 username/174.94.150.11:30407 TLS: move_session: dest=TM_ACTIVE src=TM_UNTRUSTED reinit_src=1
Wed Sep 25 12:14:56 2019 username/174.94.150.11:30407 TLS: tls_multi_process: untrusted session promoted to semi-trusted
Wed Sep 25 12:14:56 2019 username/174.94.150.11:30407 Control Channel: TLSv1.2, cipher TLSv1/SSLv3 ECDHE-RSA-AES256-GCM-SHA384, 2048 bit RSA
Wed Sep 25 12:14:57 2019 username/174.94.150.11:30407 PUSH: Received control message: 'PUSH_REQUEST'
Wed Sep 25 12:14:57 2019 username/174.94.150.11:30407 SENT CONTROL [username]: 'PUSH_REPLY,redirect-gateway def1,comp-lzo,persist-key,persist-tun,route-gateway 10.28.47.1,topology subnet,ping 10,ping-restart 120,ifconfig 10.28.47.38 255.255.255.0,peer-id 89' (status=1)
Wed Sep 25 12:14:57 2019 username/174.94.150.11:30407 Assertion failed at /path/to/openvpn-2.4.7/src/openvpn/ssl.c:1944 (ks->authenticated)

Mon Apr 16 16:20:27 2018 username/73.112.174.11:2939 WARNING: Failed running command (--auth-user-pass-verify): external program exited with error status: 1
Mon Apr 16 16:20:27 2018 username/73.112.174.11:2939 TLS Auth Error: Auth Username/Password verification failed for peer
Mon Apr 16 16:20:27 2018 username/73.112.174.11:2939 Control Channel: TLSv1.2, cipher TLSv1/SSLv3 ECDHE-RSA-AES256-GCM-SHA384, 2048 bit RSA
Mon Apr 16 16:20:28 2018 username/73.112.174.11:2939 PUSH: Received control message: 'PUSH_REQUEST'
Mon Apr 16 16:20:28 2018 username/73.112.174.11:2939 SENT CONTROL [username]: 'PUSH_REPLY,redirect-gateway def1,comp-lzo,persist-key,persist-tun,route-gateway 10.28.47.1,topology subnet,ping 10,ping-restart 120,ifconfig 10.28.47.38 255.255.255.0,peer-id 89' (status=1)
Mon Apr 16 16:20:28 2018 username/73.112.174.11:2939 Assertion failed at /path/to/openvpn-2.4.4/src/openvpn/ssl.c:1929 (ks->authenticated)

Thanks,
Jeremy

