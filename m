References: <8a2c220c-e169-0cb1-c8b4-3c8af5fab82a@...515...>
 <c573880b-af3b-0876-d00f-70e7a06c69fa@...515...>
From: Eric Thorpe <eric@...1918...>
Message-ID: <003a7779-3f07-5335-4fd4-8f62aadf6134@...1918...>
Date: Thu, 22 Mar 2018 14:25:56 +1100
MIME-Version: 1.0
In-Reply-To: <c573880b-af3b-0876-d00f-70e7a06c69fa@...515...>
Content-Type: multipart/mixed; boundary="------------FA2C64BD016E3F4F524B4418"
Content-Language: en-US
Subject: Re: [Openvpn-devel] Summary of the community meeting (Wed,
 21st Mar 2018)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------FA2C64BD016E3F4F524B4418
Content-Type: multipart/alternative;
 boundary="------------A5B6078E7494BB926BD6C86B"

--------------A5B6078E7494BB926BD6C86B
Content-Type: text/plain; charset="windows-1252"; format="flowed"
Content-Transfer-Encoding: quoted-printable

Hi All,

One of the Viscosity developers here. The TAP driver used by Viscosity=20
is based on the OpenVPN TAP-Windows driver. We're surprised to hear of=20
any performance differences, as the changes we've made are very minimal.

Besides a name and version number change, the only other modification is=20
a change to the reported network adapter speed, which has Windows report=20
the driver as 1000 Mbit instead of 100 Mbit.

This change was made not because of any actual performance gains, but=20
because of user reports that certain firewall or AV software tries to=20
QoS the adapter based on its reported adapter speed, which is of course=20
a problem if the VPN connection is capable of more than 100 Mbit.

Please find a patch file of the changes attached.

Regards,
Eric

--
Eric Thorpe
SparkLabs Developer
https://www.sparklabs.com
https://twitter.com/sparklabs
support@...1918...

On 21/03/2018 10:45 PM, Samuli Sepp=E4nen wrote:
> Hi,
>
> Here's the summary of the IRC meeting.
> ---
>
> COMMUNITY MEETING
>
> Place: #openvpn-meeting on irc.freenode.net
> Date: Wednesday 21st Mar 2018
> Time: 11:30 CET (10:30 UTC)
>
> Planned meeting topics for this meeting were here:
>
> <https://community.openvpn.net/openvpn/wiki/Topics-2018-03-21>
>
> The next meeting has not been scheduled yet.
>
> Your local meeting time is easy to check from services such as
>
> <http://www.timeanddate.com/worldclock>
>
> SUMMARY
>
> cron2, dazo, janjust, mattock, ordex and syzzer participated in
> this meeting.
>
> --
>
> Janjust initialized the meeting with virtual group hug.
>
> --
>
> Discussed the security issue in tap-windows6 reported to the security
> mailing list. While the issue is not critical it needs to be fixed.
> Mattock will produce an installer with the fix. Cron2 will compare
> unfixed and fixed versions to verify that the problem is gone. Dazo will
> get us a CVE for the problem. Once this is done we will release new
> Windows installers for OpenVPN 2.4.5.
>
> --
>
> Discussed "multi-port/multi-ip listening support: config format". The
> format agreed upon in the meeting was this:
>
>    local IP [port] [proto]
>
> Where IP can be an IPv4 address, and IPv6 address, or * which means
> dual-stack IPv4/IPv6. Proto can be either udp or tcp; the udp6 and tcp6
> variants are not needed as they can be deduced from the IP address.
>
> Note that on OpenBSD "local *" will bind to IPv6 addresses only. This is
> because v4-mapped v6 sockets are not available on that platform.
>
> --
>
> Discussed Viscosity's patches to OpenVPN and their tap-windows adapter.
> According to janjust Viscosity's tap-windows6 adapter performs
> significantly better than our tap-windows6 adapter. Agreed that we
> should first verify that they're using tap-windows6 and not something
> they wrote themselves. If yes, we should check if their source code is
> available. And if not, we should ask them to publish it according
> GPLv2's requirements.
>
> Janjust will do more testing with Viscosity's driver and report the
> results to mattock who will start bugging Viscosity as necessary.
>
> --
>
> Discussed the "netlink support: quick roadmap recap" topic. Previously
> we have agreed on providing unit tests to check the output of netlink
> with what is expected from using ip/route/ifconfig. Agreed that we
> should have unit tests in place at merge time. Otherwise we fear the
> unit tests will never arrive.
>
> Also agreed that we should try to provide testing Debian/Ubuntu package
> for this. While that is doable right now, it requires manual work. It
> would thus make more sense to automate the package creation process.
>
> --
>
> Dazo informed that OpenVPN 3 developers will start using openvpn-devel
> for their patches. We will need to figure out how to make patchwork
> detech whether a patch belongs to openvpn2 or openvpn3.
>
> ---
>
> Full chatlog attached.
>
>
>
> -------------------------------------------------------------------------=
-----
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
>
>
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel



--------------A5B6078E7494BB926BD6C86B
Content-Type: text/html; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
  <head>

    <meta http-equiv=3D"content-type" content=3D"text/html; charset=3Dwindo=
ws-1252">
  </head>
  <body text=3D"#000000" bgcolor=3D"#FFFFFF">
    <p>Hi All,<br>
      <br>
      One of the Viscosity developers here. The TAP driver used by
      Viscosity is based on the OpenVPN TAP-Windows driver. We're
      surprised to hear of any performance differences, as the changes
      we've made are very minimal.<br>
      <br>
      Besides a name and version number change, the only other
      modification is a change to the reported network adapter speed,
      which has Windows report the driver as 1000 Mbit instead of 100
      Mbit.<br>
      <br>
      This change was made not because of any actual performance gains,
      but because of user reports that certain firewall or AV software
      tries to QoS the adapter based on its reported adapter speed,
      which is of course a problem if the VPN connection is capable of
      more than 100 Mbit.<br>
      <br>
      Please find a patch file of the changes attached.<br>
    </p>
    <p>Regards,<br>
      Eric<br>
    </p>
    <pre class=3D"moz-signature" cols=3D"72">--
Eric Thorpe
SparkLabs Developer
<a class=3D"moz-txt-link-freetext" href=3D"https://www.sparklabs.com">https=
://www.sparklabs.com</a>
<a class=3D"moz-txt-link-freetext" href=3D"https://twitter.com/sparklabs">h=
ttps://twitter.com/sparklabs</a>
<a class=3D"moz-txt-link-abbreviated" href=3D"mailto:support@...1918...">su=
pport@...1918...</a></pre>
    <div class=3D"moz-cite-prefix">On 21/03/2018 10:45 PM, Samuli Sepp=E4nen
      wrote:<br>
    </div>
    <blockquote type=3D"cite"
      cite=3D"mid:c573880b-af3b-0876-d00f-70e7a06c69fa@...515..."
      id=3D"mid_c573880b_af3b_0876_d00f_70e7a06c69fa_openvpn_net" class=3D"
      cite">
      <pre wrap=3D"">Hi,

Here's the summary of the IRC meeting.
---

COMMUNITY MEETING

Place: #openvpn-meeting on irc.freenode.net
Date: Wednesday 21st Mar 2018
Time: 11:30 CET (10:30 UTC)

Planned meeting topics for this meeting were here:

<a class=3D"moz-txt-link-rfc2396E" href=3D"https://community.openvpn.net/op=
envpn/wiki/Topics-2018-03-21">&lt;https://community.openvpn.net/openvpn/wik=
i/Topics-2018-03-21&gt;</a>

The next meeting has not been scheduled yet.

Your local meeting time is easy to check from services such as

<a class=3D"moz-txt-link-rfc2396E" href=3D"http://www.timeanddate.com/world=
clock">&lt;http://www.timeanddate.com/worldclock&gt;</a>

SUMMARY

cron2, dazo, janjust, mattock, ordex and syzzer participated in
this meeting.

--

Janjust initialized the meeting with virtual group hug.

--

Discussed the security issue in tap-windows6 reported to the security
mailing list. While the issue is not critical it needs to be fixed.
Mattock will produce an installer with the fix. Cron2 will compare
unfixed and fixed versions to verify that the problem is gone. Dazo will
get us a CVE for the problem. Once this is done we will release new
Windows installers for OpenVPN 2.4.5.

--

Discussed "multi-port/multi-ip listening support: config format". The
format agreed upon in the meeting was this:

  local IP [port] [proto]

Where IP can be an IPv4 address, and IPv6 address, or * which means
dual-stack IPv4/IPv6. Proto can be either udp or tcp; the udp6 and tcp6
variants are not needed as they can be deduced from the IP address.

Note that on OpenBSD "local *" will bind to IPv6 addresses only. This is
because v4-mapped v6 sockets are not available on that platform.

--

Discussed Viscosity's patches to OpenVPN and their tap-windows adapter.
According to janjust Viscosity's tap-windows6 adapter performs
significantly better than our tap-windows6 adapter. Agreed that we
should first verify that they're using tap-windows6 and not something
they wrote themselves. If yes, we should check if their source code is
available. And if not, we should ask them to publish it according
GPLv2's requirements.

Janjust will do more testing with Viscosity's driver and report the
results to mattock who will start bugging Viscosity as necessary.

--

Discussed the "netlink support: quick roadmap recap" topic. Previously
we have agreed on providing unit tests to check the output of netlink
with what is expected from using ip/route/ifconfig. Agreed that we
should have unit tests in place at merge time. Otherwise we fear the
unit tests will never arrive.

Also agreed that we should try to provide testing Debian/Ubuntu package
for this. While that is doable right now, it requires manual work. It
would thus make more sense to automate the package creation process.

--

Dazo informed that OpenVPN 3 developers will start using openvpn-devel
for their patches. We will need to figure out how to make patchwork
detech whether a patch belongs to openvpn2 or openvpn3.

---

Full chatlog attached.

</pre>
      <br>
      <fieldset class=3D"mimeAttachmentHeader"></fieldset>
      <br>
      <pre wrap=3D"">------------------------------------------------------=
------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! <a class=3D"moz-txt-link-freetext" href=
=3D"http://sdm.link/slashdot">http://sdm.link/slashdot</a></pre>
      <br>
      <fieldset class=3D"mimeAttachmentHeader"></fieldset>
      <br>
      <pre wrap=3D"">_______________________________________________
Openvpn-devel mailing list
<a class=3D"moz-txt-link-abbreviated" href=3D"mailto:Openvpn-devel@lists.so=
urceforge.net">Openvpn-devel@lists.sourceforge.net</a>
<a class=3D"moz-txt-link-freetext" href=3D"https://lists.sourceforge.net/li=
sts/listinfo/openvpn-devel">https://lists.sourceforge.net/lists/listinfo/op=
envpn-devel</a>
</pre>
    </blockquote>
    <br>
    <br>
  </body>
</html>

--------------A5B6078E7494BB926BD6C86B--

--------------FA2C64BD016E3F4F524B4418
Content-Type: text/plain; charset=UTF-8;
 name="tap_constants.h.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="tap_constants.h.patch"

--- constants.h	Thu Mar 22 12:30:50 2018
+++ constants.h	Mon Oct 26 14:25:14 2015
@@ -38,7 +38,7 @@
 #ifndef TAP_DRIVER_MAJOR_VERSION
 
 #define TAP_DRIVER_MAJOR_VERSION           0x04
-#define TAP_DRIVER_MINOR_VERSION           0x02
+#define TAP_DRIVER_MINOR_VERSION           0x03
 
 #endif
 
@@ -102,8 +102,8 @@
 // If you have physical hardware on 802.3, use NdisPhysicalMedium802_3.
 #define TAP_PHYSICAL_MEDIUM         NdisPhysicalMediumUnspecified
 
-// Claim to be 100mbps duplex
-#define MEGABITS_PER_SECOND                1000000ULL
+// Claim to be 100mbps duplex - VISC update to 1gbit
+#define MEGABITS_PER_SECOND                10000000ULL
 #define TAP_XMIT_SPEED                     (100ULL*MEGABITS_PER_SECOND)
 #define TAP_RECV_SPEED                     (100ULL*MEGABITS_PER_SECOND)
 

--------------FA2C64BD016E3F4F524B4418--

