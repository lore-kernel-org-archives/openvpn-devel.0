Message-ID: <3552.212.51.122.2.1067768590.squirrel@...130...>
In-Reply-To: <twig.1067719215.49932@...41...>
References: <3FA22924.8010404@...129...>, <3FA22924.8010404@...129...>
    <twig.1067635476.84761@...41...>, <twig.1067635476.84761@...41...>
    <twig.1067719215.49932@...41...>
Subject: Re: [Openvpn-devel] option suggestion (was Re: routing on windows)
From: lfarkas@...129...
MIME-Version: 1.0
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Sun Nov  2 02:27:14 2003
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: James Yonan <jim@...41...>
Cc: openvpn-devel@lists.sourceforge.net

> Farkas Levente <lfarkas@...129...> said:
>
>> James Yonan wrote:
>> > Farkas Levente <lfarkas@...129...> said:
>> >
>> >
>> >>Mathias Sundman wrote:
>> >>
>> >>>Hi!
>> >>>
>> >>> > we use our linux vpn gateway and some win2000 road warrior clients
>> with
>> >>> > openvpn. I would like to route all internet traffic trough our
>> firewall
>> >>> > from the windows clients.
>> >>>
>> >>> I=B4ve been thinking about doing this too, but never accually tried
>> it.
>> >>>
>> >>> What you basicly need to do is:
>> >>>
>> >>> 1. Don=B4t set a default gateway on your ethernet adapter.
>> >>
>> >>you have to set otherwise the vpn connection can't estabilished.
>> >>
>> >>
>> >>> 2. Add a route to your openvpn server with a /32 mask pointing to
>> the
>> >>>    gateway on your ethernet.
>> >>>
>> >>>    In your exampel this would be done with the following command on
>> >>>    Win2K where w.x.y.z is the IP of your remote openvpn server,
>> >>>    and a.b.c.254 is your local gateway.
>> >>>
>> >>>    ROUTE ADD w.x.y.z MASK 255.255.255.255 a.b.c.254
>> >>>
>> >>> 3. Setup OpenVPN as usual but also add a default gateway route to
>> >>>    the TAP interface.
>> >>>
>> >>>
>> >>> The reason why I havn=B4t tried this is because I don=B4t know how to
>> solve
>> >>> the problem that the ROUTE command will be diffrent for each network
>> you
>> >>> hook your laptop into. So if you don=B4t want to manually do this
>> every
>> >>> time, you would need to write a little app that looks at the IP and
>> >>> default gateway that has been assigned by DHCP, switch to static IP
>> and
>> >>> add the correct route.
>> >>>
>> >>> Anyone that has a better solution to this?
>> >>
>> >>you see exactly the problem!
>> >>on linux I can do (eg. in the up script):
>> >>----------------------------------
>> >>route add -host <remote-server-ip> dev ppp0
>> >>route del default dev ppp0
>> >>route add default dev tun0
>> >>----------------------------------
>> >>and we got it, but unfotunately on windows you can't route by
>> interface
>> >>(or to be more precise on windos the interface is defined by it's ip
>> >>address even if you can specify the interface).
>> >>so I'd like to suggest a new option for openvpn to be portable (like
>> in
>> >>the case of --route):
>> >>--route-internal
>> >>   which do exactly as the above on all platform.
>> >>since openvpn know whcih ip address has the under the tun/tap
>> interface.
>> >>or may it would be more better if the up script has one more (6th)
>> >>paramter and the underlying interface's ip address:
>> >>-----------------------------------
>> >>cmd tun_dev tun_mtu link_mtu ifconfig_local_ip ifconfig_remote_ip
>> >>underlying_ip [ init | restart ]
>> >>cmd tap_dev tap_mtu link_mtu ifconfig_local_ip ifconfig_netmask
>> >>underlying_ip [ init | restart ]
>> >>-----------------------------------
>> >>and in this case on linux we cn write an up script as:
>> >>----------------------------------
>> >>route add -host $5 dev ppp0
>> >>route del default dev ppp0
>> >>route add default dev tun0
>> >>----------------------------------
>> >>while on windows
>> >>----------------------------------
>> >>route add $5 gw $6
>> >>route delete 0.0.0.0 mask 0.0.0.0 $5
>> >>route add 0.0.0.0 mask 0.0.0.0 $4
>> >>----------------------------------
>> >>does it possible? or any better solution?
>> >
>> >
>> > When you say "underlying_ip" I assume you mean the original default
>> gateway
>> > (before the up script (might have) changed it)?
>> >
>> > I agree that it would be useful to provide an "original default
>> gateway"
>> > parameter to up scripts.
>>
>> yes.
>>
>> > This would provide the support necessary to conveniently route all IP
>> traffic
>> > through the VPN tunnel.
>> >
>> > Unfortunately, as is often the case with network configuration, there
>> is no
>> > standard API for doing this.
>> >
>> > To make this work in OpenVPN, you would need to follow the model of
>> tun.c and
>> > route.c where there is a function such as get_default_gateway that has
>> a bunch
>> > of #ifdefs for each platform.
>> >
>> > If you want this to work on Windows right now, I would suggest you run
>> "route
>> > print" in your up script and pipe the output to a program which parses
>> out the
>> > "default gateway" information and returns it to the script.
>>
>> that's what I wouldn't like to! if openvpn already contains this code
>> (get_default_gateway) and you knoe that this is very difficult to find
>> out than why openvpn provide it for us?
>> that would be a big help!
>> thanks in advace:-)
>
> Good news.  I threw together some code under a new flag called
> --redirect-gateway that will do the routing smarts to redirect the default
> gateway into the tunnel, and undo its actions on tun/tap close.
>
> Keep in mind that there's no standard API for getting the current default
> gateway.  That means there's yet another #if block at the bottom of
> route.c
> for each platform's version of get_default_gateway().  I've only
> implemented
> for Linux and Windows so far.
>
> It will be out with beta13... If you are adventurous, the patch is already
> committed to the CVS, if you'd like to test or add support for other OSes
> besides Linux and Windows.

thanks!!! I'll try tomorrow.
I just make this small patch to your code to conform better to your coding
style:-)
-------------------------------------
--- ./route.c.lfarkas   2003-11-02 10:57:38.000000000 +0100
+++ ./route.c   2003-11-02 11:06:46.000000000 +0100
@@ -709,11 +709,12 @@
  * to get the current default gateway.
  */

-#if defined(WIN32)
-
 static bool
 get_default_gateway (in_addr_t *ret)
 {
+
+#if defined(WIN32)
+
   ULONG size =3D 0;
   DWORD status;

@@ -747,14 +748,9 @@
            }
        }
     }
-  return false;
-}

 #elif defined(TARGET_LINUX)

-static bool
-get_default_gateway (in_addr_t *ret)
-{
   FILE *fp =3D fopen ("/proc/net/route", "r");
   if (fp)
     {
@@ -794,15 +790,10 @@
        }
       fclose (fp);
     }
-  return false;
-}

 #else
+#endif

-static bool
-get_default_gateway (in_addr_t *ret)
-{
   return false;
 }

-#endif
-------------------------------------



