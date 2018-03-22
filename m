References: <8a2c220c-e169-0cb1-c8b4-3c8af5fab82a@...515...>
 <c573880b-af3b-0876-d00f-70e7a06c69fa@...515...>
 <003a7779-3f07-5335-4fd4-8f62aadf6134@...1918...>
From: Jan Just Keijser <janjust@...1147...>
Message-ID: <9678ca1e-2ef6-22ff-7992-c579902fe15a@...1147...>
Date: Thu, 22 Mar 2018 17:16:46 +0100
MIME-Version: 1.0
In-Reply-To: <003a7779-3f07-5335-4fd4-8f62aadf6134@...1918...>
Content-Type: multipart/alternative;
 boundary="------------CAD4B177EE6A6EDC0B03FADF"
Content-Language: nl-NL
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
To: Eric Thorpe <eric@...1918...>, openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------CAD4B177EE6A6EDC0B03FADF
Content-Type: text/plain; charset="windows-1252"; format="flowed"
Content-Transfer-Encoding: quoted-printable

Hi Eric, all,

On 22/03/18 04:25, Eric Thorpe wrote:
>
> Hi All,
>
> One of the Viscosity developers here. The TAP driver used by Viscosity=20
> is based on the OpenVPN TAP-Windows driver. We're surprised to hear of=20
> any performance differences, as the changes we've made are very minimal.
>
> Besides a name and version number change, the only other modification=20
> is a change to the reported network adapter speed, which has Windows=20
> report the driver as 1000 Mbit instead of 100 Mbit.
>
> This change was made not because of any actual performance gains, but=20
> because of user reports that certain firewall or AV software tries to=20
> QoS the adapter based on its reported adapter speed, which is of=20
> course a problem if the VPN connection is capable of more than 100 Mbit.
>
> Please find a patch file of the changes attached.
>

first of all, thanks for responding so quickly.
I've done some further testing with Viscosity 1.6.8 (openvpn 2.3.14=20
based) compared to OpenVPN 2.4.5 and I am seeing a performance=20
difference in a gigabit test setup.=A0 Strangely enough, it turns out that =

it's the *absence of* AES256-GCM that makes my Viscosity client faster.
My test setup is as follows:

- server: CentOS 7, openvpn 2.4.4, gigabit ethernet
- client: Win7 Pro, gigabit ethernet:

Speeds (using "iperf -s" and "iperf -c 10.200.0.1 -r -l 4M -t 30"):

viscosity:
380 Mbps +/- 10 Mbps to server
100 Mbps +/- 5 Mpbs from server

Openvpn 2.4.5=A0 --ncp-disable --cipher aes-256-cbc --auth sha256
377 Mbps +/- 10 Mbps to server
99 Mbps +/- 5 Mpbs from server

Openvpn 2.4.5 (aes256-gcm)
 =A0240 Mbps +/- 8 Mbps to server
 =A0 55 Mbps +/- 5 Mpbs from server

So strangely enough it seems that AES-256-GCM is **slower** for Windows=20
clients. Note that in this setup the server config never changed.

I hope someone else can verify these results (or refute them and tell me=20
what I am doing wrong ;))

HTH,

JJK


On 21/03/2018 10:45 PM, Samuli Sepp=E4nen wrote:
>> Hi,
>>
>> Here's the summary of the IRC meeting.
>> ---
>>
>> COMMUNITY MEETING
>>
>> Place: #openvpn-meeting on irc.freenode.net
>> Date: Wednesday 21st Mar 2018
>> Time: 11:30 CET (10:30 UTC)
>>
>> Planned meeting topics for this meeting were here:
>>
>> <https://community.openvpn.net/openvpn/wiki/Topics-2018-03-21>
>>
>> The next meeting has not been scheduled yet.
>>
>> Your local meeting time is easy to check from services such as
>>
>> <http://www.timeanddate.com/worldclock>
>>
>> SUMMARY
>>
>> cron2, dazo, janjust, mattock, ordex and syzzer participated in
>> this meeting.
>>
>> --
>>
>> Janjust initialized the meeting with virtual group hug.
>>
>> --
>>
>> Discussed the security issue in tap-windows6 reported to the security
>> mailing list. While the issue is not critical it needs to be fixed.
>> Mattock will produce an installer with the fix. Cron2 will compare
>> unfixed and fixed versions to verify that the problem is gone. Dazo will
>> get us a CVE for the problem. Once this is done we will release new
>> Windows installers for OpenVPN 2.4.5.
>>
>> --
>>
>> Discussed "multi-port/multi-ip listening support: config format". The
>> format agreed upon in the meeting was this:
>>
>>    local IP [port] [proto]
>>
>> Where IP can be an IPv4 address, and IPv6 address, or * which means
>> dual-stack IPv4/IPv6. Proto can be either udp or tcp; the udp6 and tcp6
>> variants are not needed as they can be deduced from the IP address.
>>
>> Note that on OpenBSD "local *" will bind to IPv6 addresses only. This is
>> because v4-mapped v6 sockets are not available on that platform.
>>
>> --
>>
>> Discussed Viscosity's patches to OpenVPN and their tap-windows adapter.
>> According to janjust Viscosity's tap-windows6 adapter performs
>> significantly better than our tap-windows6 adapter. Agreed that we
>> should first verify that they're using tap-windows6 and not something
>> they wrote themselves. If yes, we should check if their source code is
>> available. And if not, we should ask them to publish it according
>> GPLv2's requirements.
>>
>> Janjust will do more testing with Viscosity's driver and report the
>> results to mattock who will start bugging Viscosity as necessary.
>>
>> --
>>
>> Discussed the "netlink support: quick roadmap recap" topic. Previously
>> we have agreed on providing unit tests to check the output of netlink
>> with what is expected from using ip/route/ifconfig. Agreed that we
>> should have unit tests in place at merge time. Otherwise we fear the
>> unit tests will never arrive.
>>
>> Also agreed that we should try to provide testing Debian/Ubuntu package
>> for this. While that is doable right now, it requires manual work. It
>> would thus make more sense to automate the package creation process.
>>
>> --
>>
>> Dazo informed that OpenVPN 3 developers will start using openvpn-devel
>> for their patches. We will need to figure out how to make patchwork
>> detech whether a patch belongs to openvpn2 or openvpn3.
>>
>> ---
>>
>> Full chatlog attached.
>>
>>
>>
>> ------------------------------------------------------------------------=
------
>> Check out the vibrant tech community on one of the world's most
>> engaging tech sites, Slashdot.org!http://sdm.link/slashdot
>>
>>
>> _______________________________________________
>> Openvpn-devel mailing list
>> Openvpn-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>
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



--------------CAD4B177EE6A6EDC0B03FADF
Content-Type: text/html; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
  <head>
    <meta http-equiv=3D"Content-Type" content=3D"text/html;
      charset=3Dwindows-1252">
  </head>
  <body text=3D"#000000" bgcolor=3D"#FFFFFF">
    <div class=3D"moz-cite-prefix">Hi Eric, all,<br>
      <br>
      On 22/03/18 04:25, Eric Thorpe wrote:<br>
    </div>
    <blockquote type=3D"cite"
      cite=3D"mid:003a7779-3f07-5335-4fd4-8f62aadf6134@...1918...">
      <meta http-equiv=3D"content-type" content=3D"text/html;
        charset=3Dwindows-1252">
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
        This change was made not because of any actual performance
        gains, but because of user reports that certain firewall or AV
        software tries to QoS the adapter based on its reported adapter
        speed, which is of course a problem if the VPN connection is
        capable of more than 100 Mbit.<br>
        <br>
        Please find a patch file of the changes attached.<br>
      </p>
    </blockquote>
    <br>
    first of all, thanks for responding so quickly.<br>
    I've done some further testing with Viscosity 1.6.8 (openvpn 2.3.14
    based) compared to OpenVPN 2.4.5 and I am seeing a performance
    difference in a gigabit test setup.=A0 Strangely enough, it turns out
    that it's the *absence of* AES256-GCM that makes my Viscosity client
    faster.<br>
    My test setup is as follows:<br>
    <br>
    - server: CentOS 7, openvpn 2.4.4, gigabit ethernet<br>
    - client: Win7 Pro, gigabit ethernet:<br>
    <br>
    Speeds (using "iperf -s" and "iperf -c 10.200.0.1 -r -l 4M -t 30"):<br>
    <br>
    viscosity:=A0 <br>
    380 Mbps +/- 10 Mbps to server<br>
    100 Mbps +/- 5 Mpbs from server<br>
    <br>
    Openvpn 2.4.5=A0 --ncp-disable --cipher aes-256-cbc --auth sha256<br>
    377 Mbps +/- 10 Mbps to server<br>
    =A0
    99 Mbps +/- 5 Mpbs from server<br>
    <br>
    Openvpn 2.4.5 (aes256-gcm)<br>
    =A0240 Mbps +/- 8 Mbps to server<br>
    =A0 55 Mbps +/- 5 Mpbs from server<br>
    <br>
    So strangely enough it seems that AES-256-GCM is **slower** for
    Windows clients. Note that in this setup the server config never
    changed.<br>
    <br>
    I hope someone else can verify these results (or refute them and
    tell me what I am doing wrong ;)) <br>
    <br>
    HTH,<br>
    <br>
    JJK<br>
    <br>
    <br>
    On 21/03/2018 10:45 PM, Samuli Sepp=E4nen wrote:<br>
    <blockquote type=3D"cite"
      cite=3D"mid:003a7779-3f07-5335-4fd4-8f62aadf6134@...1918...">
      <blockquote type=3D"cite"
        cite=3D"mid:c573880b-af3b-0876-d00f-70e7a06c69fa@...515..."
        id=3D"mid_c573880b_af3b_0876_d00f_70e7a06c69fa_openvpn_net"
        class=3D" cite">
        <pre wrap=3D"">Hi,

Here's the summary of the IRC meeting.
---

COMMUNITY MEETING

Place: #openvpn-meeting on irc.freenode.net
Date: Wednesday 21st Mar 2018
Time: 11:30 CET (10:30 UTC)

Planned meeting topics for this meeting were here:

<a class=3D"moz-txt-link-rfc2396E" href=3D"https://community.openvpn.net/op=
envpn/wiki/Topics-2018-03-21" moz-do-not-send=3D"true">&lt;https://communit=
y.openvpn.net/openvpn/wiki/Topics-2018-03-21&gt;</a>

The next meeting has not been scheduled yet.

Your local meeting time is easy to check from services such as

<a class=3D"moz-txt-link-rfc2396E" href=3D"http://www.timeanddate.com/world=
clock" moz-do-not-send=3D"true">&lt;http://www.timeanddate.com/worldclock&g=
t;</a>

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
        <pre wrap=3D"">----------------------------------------------------=
--------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! <a class=3D"moz-txt-link-freetext" href=
=3D"http://sdm.link/slashdot" moz-do-not-send=3D"true">http://sdm.link/slas=
hdot</a></pre>
        <br>
        <fieldset class=3D"mimeAttachmentHeader"></fieldset>
        <br>
        <pre wrap=3D"">_______________________________________________
Openvpn-devel mailing list
<a class=3D"moz-txt-link-abbreviated" href=3D"mailto:Openvpn-devel@lists.so=
urceforge.net" moz-do-not-send=3D"true">Openvpn-devel@lists.sourceforge.net=
</a>
<a class=3D"moz-txt-link-freetext" href=3D"https://lists.sourceforge.net/li=
sts/listinfo/openvpn-devel" moz-do-not-send=3D"true">https://lists.sourcefo=
rge.net/lists/listinfo/openvpn-devel</a>
</pre>
      </blockquote>
      <br>
      <br>
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

--------------CAD4B177EE6A6EDC0B03FADF--

