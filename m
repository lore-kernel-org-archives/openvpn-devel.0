MIME-Version: 1.0
In-Reply-To: <4B8C40D9.8030208@...1147...>
References: <d8e57f271003010640u307d1914od54b8bafce467750@...278...>
	<4B8C40D9.8030208@...1147...>
Date: Tue, 2 Mar 2010 15:06:34 -0300
Message-ID: <d8e57f271003021006v36871150obc7080725bc6efb3@...278...>
From: Giancarlo Rubio <gianrubio@...277...>
Subject: Re: [Openvpn-devel] [Openvpn-users] bug? wrong CN in
	client-disconnect with username-as-common-name
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Jan Just Keijser <janjust@...1147...>
Cc: openvpn-devel@lists.sourceforge.net, openvpn-users@lists.sourceforge.net

Jan:

Thank's for the help. I have patched my openvpn and the problem was solved.
Behinhd are the patches for openvpn-2.0.9 and openvpn-2.1.1.
Devel's please incorporate this to openvpn code.

----------------------------------------- 2.0.9
------------------------------------------
----------------------------------------- Begin
-----------------------------------------
rubio@...1313...:~/openvpn-2.0.9$ diff -Nru multi.c multi.c-patched
--- multi.c	2010-03-02 14:55:53.000000000 -0300
+++ multi.c-patched	2010-03-02 14:39:46.000000000 -0300
@@ -393,6 +393,9 @@
 				struct multi_instance *mi)
 {
=20=09
+  /* setenv incoming cert common name for script */
+  setenv_str (mi->context.c2.es, "common_name", tls_common_name
(mi->context.c2.tls_multi, true));
+
   /* setenv client real IP address */
   setenv_trusted (mi->context.c2.es, get_link_socket_info (&mi->context));
----------------------------------------- END
-------------------------------------------
----------------------------------------- 2.0.9
------------------------------------------


----------------------------------------- 2.1.1
------------------------------------------
----------------------------------------- Begin
-----------------------------------------
rubio@...1314...:~/openvpn-2.1.1$ diff -Nru multi.c multi.c.patched
--- multi.c	2009-10-24 21:17:29.000000000 -0200
+++ multi.c.patched	2010-03-02 14:57:12.000000000 -0300
@@ -447,6 +447,9 @@
 multi_client_disconnect_setenv (struct multi_context *m,
 				struct multi_instance *mi)
 {
+  /* setenv incoming cert common name for script */
+  setenv_str (mi->context.c2.es, "common_name", tls_common_name
(mi->context.c2.tls_multi, true));
+
   /* setenv client real IP address */
   setenv_trusted (mi->context.c2.es, get_link_socket_info (&mi->context));

----------------------------------------- END
-------------------------------------------
----------------------------------------- 2.0.9
------------------------------------------

2010/3/1 Jan Just Keijser <janjust@...1147...>:
> Hi,
>
> Giancarlo Rubio wrote:
>>
>> Hi all.
>>
>> I have a issue with "OpenVPN 2.0.9 i586-suse-linux [SSL] [LZO]
>> [EPOLL]" =A0similiar to other user [1]. Using options
>> --client-disconnect (to use firewall rules),
>> --username-as-common-name, sometimes, the disconnect-script return
>> erroneous CN. I use iptables rules to connect and disconnect clients,
>> the connect are ok, but disconnect receive invalid CN and the firewall
>> rule still invalid, because any user have a firewall ruleset based on
>> his CN.
>>
>> Details
>>
>> # cat /var/log/openvpn-status.log
>> OpenVPN CLIENT LIST
>> Updated,Mon Mar =A01 11:28:22 2010
>> Common Name,Real Address,Bytes Received,Bytes Sent,Connected Since
>> user1,xxxxx,74953,83914,Mon Mar =A01 10:33:13 2010
>> user2,xxxxx,2080665,8540472,Mon Mar =A01 08:51:36 2010
>> user3,xxxxx,3493297,7694229,Mon Mar =A01 07:48:33 2010
>> user4,xxxx,609998,1533127,Mon Mar =A01 09:43:43 2010
>> ROUTING TABLE
>> Virtual Address,Common Name,Real Address,Last Ref
>> 10.8.0.6,user1,xxxxx,Mon Mar =A01 11:28:00 2010
>> 10.8.0.110,user2,xxxxxx,Mon Mar =A01 11:28:15 2010
>> 10.8.0.106,user3,xxxxxx,Mon Mar =A01 11:28:20 2010
>> 10.8.0.42,user4,xxxxx,Mon Mar =A01 11:28:13 2010
>> GLOBAL STATS
>> Max bcast/mcast queue length,0
>> END
>>
>> * Firewall rules
>>
>> Chain FORWARD (policy DROP 1434 packets, 151K bytes)
>> =A0pkts bytes target =A0 =A0 prot opt in =A0 =A0 out =A0 =A0 source
>> destination
>> =A0 11 =A0 876 ACCEPT =A0 =A0 all =A0-- =A0* =A0 =A0 =A0* =A0 =A0 =A0 10=
.8.0.126
>> 12.86.0.0/16
>> =A0 10 =A0 671 ACCEPT =A0 =A0 all =A0-- =A0* =A0 =A0 =A0* =A0 =A0 =A0 12=
.86.0.0/16
>> 10.8.0.126
>> 21773 1293K ACCEPT =A0 =A0 all =A0-- =A0* =A0 =A0 =A0* =A0 =A0 =A0 10.8.=
0.34
>> 182.36.1.34
>> 22171 5480K ACCEPT =A0 =A0 all =A0-- =A0* =A0 =A0 =A0* =A0 =A0 =A0 182.3=
6.1.34
>> 10.8.0.34
>> =A03042 1987K ACCEPT =A0 =A0 all =A0-- =A0* =A0 =A0 =A0* =A0 =A0 =A0 10.=
8.0.90
>> 182.36.1.4
>> =A04020 2839K ACCEPT =A0 =A0 all =A0-- =A0* =A0 =A0 =A0* =A0 =A0 =A0 182=
.36.1.4
>> 10.8.0.90
>> 12557 3871K ACCEPT =A0 =A0 all =A0-- =A0* =A0 =A0 =A0* =A0 =A0 =A0 10.8.=
0.42
>> 12.86.0.0/16
>> 13036 8805K ACCEPT =A0 =A0 all =A0-- =A0* =A0 =A0 =A0* =A0 =A0 =A0 12.86=
.0.0/16
>> 10.8.0.42
>> =A0338 54579 ACCEPT =A0 =A0 all =A0-- =A0* =A0 =A0 =A0* =A0 =A0 =A0 10.8=
.0.42
>> 122.16.35.0/23
>> =A0264 28680 ACCEPT =A0 =A0 all =A0-- =A0* =A0 =A0 =A0* =A0 =A0 =A0 122.=
16.35.0/23
>> 10.8.0.42
>> 10151 1673K ACCEPT =A0 =A0 all =A0-- =A0* =A0 =A0 =A0* =A0 =A0 =A0 10.8.=
0.106
>> 12.86.0.0/16
>> 11612 9301K ACCEPT =A0 =A0 all =A0-- =A0* =A0 =A0 =A0* =A0 =A0 =A0 12.86=
.0.0/16
>> 10.8.0.106
>> =A0112 =A0132K ACCEPT =A0 =A0 all =A0-- =A0* =A0 =A0 =A0* =A0 =A0 =A0 10=
.8.0.106
>> 122.16.35.0/23
>> =A0 83 =A03344 ACCEPT =A0 =A0 all =A0-- =A0* =A0 =A0 =A0* =A0 =A0 =A0 12=
2.16.35.0/23
>> 10.8.0.106
>> =A03199 =A0523K ACCEPT =A0 =A0 all =A0-- =A0* =A0 =A0 =A0* =A0 =A0 =A0 1=
0.8.0.110
>> 12.86.0.0/16
>> =A03290 1765K ACCEPT =A0 =A0 all =A0-- =A0* =A0 =A0 =A0* =A0 =A0 =A0 12.=
86.0.0/16
>> 10.8.0.110
>> =A0 =A00 =A0 =A0 0 ACCEPT =A0 =A0 all =A0-- =A0* =A0 =A0 =A0* =A0 =A0 =
=A0 10.8.0.110
>> 122.16.35.0/23
>> =A0 =A00 =A0 =A0 0 ACCEPT =A0 =A0 all =A0-- =A0* =A0 =A0 =A0* =A0 =A0 =
=A0 122.16.35.0/23
>> 10.8.0.110
>> =A03165 =A0331K ACCEPT =A0 =A0 all =A0-- =A0* =A0 =A0 =A0* =A0 =A0 =A0 1=
0.8.0.38
>> 12.86.0.0/16
>> =A03681 3122K ACCEPT =A0 =A0 all =A0-- =A0* =A0 =A0 =A0* =A0 =A0 =A0 12.=
86.0.0/16
>> 10.8.0.38
>> =A0430 =A0486K ACCEPT =A0 =A0 all =A0-- =A0* =A0 =A0 =A0* =A0 =A0 =A0 10=
.8.0.38
>> 122.16.35.0/23
>> =A0302 13545 ACCEPT =A0 =A0 all =A0-- =A0* =A0 =A0 =A0* =A0 =A0 =A0 122.=
16.35.0/23
>> 10.8.0.38
>> =A0529 35483 ACCEPT =A0 =A0 all =A0-- =A0* =A0 =A0 =A0* =A0 =A0 =A0 10.8=
.0.6
>> 12.86.0.0/16
>> =A0387 50812 ACCEPT =A0 =A0 all =A0-- =A0* =A0 =A0 =A0* =A0 =A0 =A0 12.8=
6.0.0/16
>> 10.8.0.6
>> =A0 =A00 =A0 =A0 0 ACCEPT =A0 =A0 all =A0-- =A0* =A0 =A0 =A0* =A0 =A0 =
=A0 10.8.0.6
>> 122.16.35.0/23
>> =A0 =A00 =A0 =A0 0 ACCEPT =A0 =A0 all =A0-- =A0* =A0 =A0 =A0* =A0 =A0 =
=A0 122.16.35.0/23
>> 10.8.0.6
>>
>> if you look on connect clients only
>> 10.8.0.6,10.8.0.110,10.8.0.106,10.8.0.42 are connected, but rules that
>> 10.8.0.38,10.8.0.34 are in the firewall.
>> It's not firewall rule problem, is the wrong CN cause this.
>>
>> * My certificate name was "cliente".
>> * The CN in openvpn.log are correct, only in disconnect script is the
>> problem.
>>
>> Mon Mar =A01 00:28:33 2010 us=3D813731 user2/201.25.210.77:60054
>> SIGTERM[soft,remote-exit] received, client-instance exiting
>> ..........
>>
>> Mon Mar =A01 09:41:02 2010 us=3D98845 user1/187.88.88.67:1090 [hrsilva]
>> Inactivity timeout (--ping-restart), restarting
>> Mon Mar =A01 09:41:02 2010 us=3D98899 user1/187.88.88.67:1090
>> SIGUSR1[soft,ping-restart] received, client-instance restarting
>> ..........
>>
>> Mon Mar =A01 09:44:43 2010 us=3D226821 user3/187.88.200.66:1108
>> [lffernandez] Inactivity timeout (--ping-restart), restarting
>> Mon Mar =A01 09:44:43 2010 us=3D226856 user3/187.88.200.66:1108
>> SIGUSR1[soft,ping-restart] received, client-instance restarting
>>
>>
>>
>> Behind are the same description off the problem by other user.
>>
>> ----------------------
>>
>> A few days ago I've set up an openvpn server on my server with mysql
>> backend
>> based on auth-user-pass-verify, client-connect, client-disconnect. Both
>> client-connect and client-disconnect works has a main purpuse of setting
>> iptables rules for forwarding each connection to a public ip, taken from
>> an
>> ip-pool table. Also, each connection is registered in a table called
>> active.
>> When the client disconnects, it deletes from active, deletes the iptables
>> rule and logs everything...
>>
>> The authentication and every record is indexed by the common name (which
>> is
>> the username, not the cert name, so username-as-common-name on ).. so if=
 i
>> add a row in the "active" table with client-connect and then look for it
>> with client-disconnect, it is based on the common name.
>>
>> So, now about the problem: some of the time (about 1 every 5 disconnect)
>> the
>> $common-name variable shows the cert name and not the username, thus
>> making
>> it impossible to find in active table, leaving many false iptables rules
>> and
>> funny logs like:
>>
>> username =A0 =A0 =A0 =A0 =A0 1245682814 =A0 =A0 =A0 =A080.99.12.202 =A0 =
=A0 =A079.172.201.189
>> 10.0.0.2 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0CONNECT
>>
>> certname =A0 =A0 =A0 =A0 =A0 =A01245685700 =A0 =A0 =A0 =A080.99.12.202
>> 10.0.0.2 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0DISCONNECT
>>
>>
>>
>> Is this a bug or did i make a mistake?
>>
>>
>
> congratulations, you have found a bug indeed...
> I'm posting my analysis here but will copy it later to openvpn-devel, so =
we
> can figure out what to do with it:
>
> in multi.c the function multi_client_connect_setenv contains
>
> 1410 =A0 /* setenv incoming cert common name for script */
> 1411 =A0 setenv_str (mi->context.c2.es, "common_name", tls_common_name
> (mi->context.c2.tls_multi, true));
>
> this is missing from the corresponding multi_client_disconnect_setenv
> function....
>
> So you can either patch multi.c yourself or perhaps you can record the na=
me
> of the username when you set up the firewall rules so that you can also u=
se
> that username to tear it down again (e.g. match IP to username or somethi=
ng
> like that).
>
> HTH,
>
> JJK
>
>



--=20
Giancarlo Rubio

