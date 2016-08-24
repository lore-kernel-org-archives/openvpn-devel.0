Message-ID: <57BD5706.2080305@...1147...>
Date: Wed, 24 Aug 2016 10:12:54 +0200
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
References: <1451908945-12244-1-git-send-email-lstipakov@...277...>	<1451911424-12970-1-git-send-email-lstipakov@...277...>	<20160822191828.GT78279@...1296...>
	<20160823134336.GE78279@...1296...>
In-Reply-To: <20160823134336.GE78279@...1296...>
Content-Type: multipart/alternative;
	boundary="------------070105040303000803040006"
Subject: Re: [Openvpn-devel] [PATCH v2] Drop recursively routed packets
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>, Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------070105040303000803040006
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 23/08/16 15:43, Gert Doering wrote:
> Hi,
>
> On Mon, Aug 22, 2016 at 09:18:28PM +0200, Gert Doering wrote:
>> On Mon, Jan 04, 2016 at 02:43:44PM +0200, Lev Stipakov wrote:
>>> v2: better method naming
> [..]
>>> Trac #642
>>>
>>> Signed-off-by: Lev Stipakov <lstipakov@...277...>
>> ACK.
> As stupid as this feels - we need to back this out again, because it
> breaks TAP mode.  Buildbot complained that all tap tests failed, and
> manually bisecting master nailed it to *this* patch, and release/2.3
> is similarily broken.

may I suggest to make this configurable, i.e. the user can specify 
whether rec routed packets should be dropped?  I'm afraid that we might 
end up with code that drops packets that really should not be dropped - 
people do weird things with routing: in 99% of the cases in error, but 
in 1% of the cases because they want to do something funky.

It would also make it easy to include the current code in 2.3 - turn it 
on in TUN mode by default and OFF in TAP mode.

JM2CW,

JJK

> On the server side, for a t_client test with --dev tap, with this patch,
> you see "the source mac is rotating"
>
> Aug 23 09:37:24 phillip tap-udp-p2mp[60213]: cron2-gentoo-i386/193.xx.xx.xx MULTI: Learn: 20:00:40:01:d8:7a -> cron2-gentoo-i386/193.xx.xx.xx
> Aug 23 09:37:24 phillip tap-udp-p2mp[60213]: cron2-gentoo-i386/193.xx.xx.xx MULTI: Learn: 20:b9:40:01:d7:c1 -> cron2-gentoo-i386/193.xx.xx.xx
> Aug 23 09:37:24 phillip tap-udp-p2mp[60213]: cron2-gentoo-i386/193.xx.xx.xx MULTI: bad source address from client [01:72:40:01:fc:a0], packet dropped
> Aug 23 09:37:24 phillip tap-udp-p2mp[60213]: cron2-gentoo-i386/193.xx.xx.xx MULTI: Learn: 20:00:40:01:3e:b1 -> cron2-gentoo-i386/193.xx.xx.xx
> Aug 23 09:37:24 phillip tap-udp-p2mp[60213]: cron2-gentoo-i386/193.xx.xx.xx MULTI: Learn: 20:b9:40:01:3d:f8 -> cron2-gentoo-i386/193.xx.xx.xx
> Aug 23 09:37:24 phillip tap-udp-p2mp[60213]: cron2-gentoo-i386/193.xx.xx.xx MULTI: bad source address from client [01:72:40:01:62:d7], packet dropped
> Aug 23 09:37:24 phillip tap-udp-p2mp[60213]: cron2-gentoo-i386/193.xx.xx.xx MULTI: Learn: 20:00:40:01:d7:d8 -> cron2-gentoo-i386/193.xx.xx.xx
>
> ... which looks like "the IP header ends up where the ethernet header
> should be" (every ping packet shows up as "new source address" on the
> openvpn server).
>
> I have no idea what this could be, but since we want 2.3.12 out *today*,
> we'll need to back it out of 2.3 for the time being.
>
> Lev, do you have time to investigate?
>
> gert
>
>
>
> ------------------------------------------------------------------------------
>
>
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel


--------------070105040303000803040006
X-MIME-Autoconverted: from 8bit to quoted-printable by
	outgoing3-ams.mf.surf.net id u7O8CtiI016744
Content-Type: text/html; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
  <head>
    <meta content=3D"text/html; charset=3Dwindows-1252"
      http-equiv=3D"Content-Type">
  </head>
  <body bgcolor=3D"#FFFFFF" text=3D"#000000">
    <div class=3D"moz-cite-prefix">Hi,<br>
      <br>
      On 23/08/16 15:43, Gert Doering wrote:<br>
    </div>
    <blockquote cite=3D"mid:20160823134336.GE78279@...1296..."
      type=3D"cite">
      <pre wrap=3D"">Hi,

On Mon, Aug 22, 2016 at 09:18:28PM +0200, Gert Doering wrote:
</pre>
      <blockquote type=3D"cite">
        <pre wrap=3D"">On Mon, Jan 04, 2016 at 02:43:44PM +0200, Lev Stipak=
ov wrote:
</pre>
        <blockquote type=3D"cite">
          <pre wrap=3D"">v2: better method naming
</pre>
        </blockquote>
      </blockquote>
      <pre wrap=3D"">[..]
</pre>
      <blockquote type=3D"cite">
        <blockquote type=3D"cite">
          <pre wrap=3D"">Trac #642

Signed-off-by: Lev Stipakov <a class=3D"moz-txt-link-rfc2396E" href=3D"mail=
to:lstipakov@...277...">&lt;lstipakov@...277...&gt;</a>
</pre>
        </blockquote>
        <pre wrap=3D"">
ACK.
</pre>
      </blockquote>
      <pre wrap=3D"">
As stupid as this feels - we need to back this out again, because it
breaks TAP mode.  Buildbot complained that all tap tests failed, and
manually bisecting master nailed it to *this* patch, and release/2.3
is similarily broken.
</pre>
    </blockquote>
    <br>
    may I suggest to make this configurable, i.e. the user can specify
    whether rec routed packets should be dropped?=A0 I'm afraid that we
    might end up with code that drops packets that really should not be
    dropped - people do weird things with routing: in 99% of the cases
    in error, but in 1% of the cases because they want to do something
    funky.<br>
    <br>
    It would also make it easy to include the current code in 2.3 - turn
    it on in TUN mode by default and OFF in TAP mode.<br>
    <br>
    JM2CW,<br>
    <br>
    JJK<br>
    <br>
    <blockquote cite=3D"mid:20160823134336.GE78279@...1296..."
      type=3D"cite">
      <pre wrap=3D"">
On the server side, for a t_client test with --dev tap, with this patch,
you see "the source mac is rotating"

Aug 23 09:37:24 phillip tap-udp-p2mp[60213]: cron2-gentoo-i386/193.xx.xx.xx=
 MULTI: Learn: 20:00:40:01:d8:7a -&gt; cron2-gentoo-i386/193.xx.xx.xx
Aug 23 09:37:24 phillip tap-udp-p2mp[60213]: cron2-gentoo-i386/193.xx.xx.xx=
 MULTI: Learn: 20:b9:40:01:d7:c1 -&gt; cron2-gentoo-i386/193.xx.xx.xx
Aug 23 09:37:24 phillip tap-udp-p2mp[60213]: cron2-gentoo-i386/193.xx.xx.xx=
 MULTI: bad source address from client [01:72:40:01:fc:a0], packet dropped
Aug 23 09:37:24 phillip tap-udp-p2mp[60213]: cron2-gentoo-i386/193.xx.xx.xx=
 MULTI: Learn: 20:00:40:01:3e:b1 -&gt; cron2-gentoo-i386/193.xx.xx.xx
Aug 23 09:37:24 phillip tap-udp-p2mp[60213]: cron2-gentoo-i386/193.xx.xx.xx=
 MULTI: Learn: 20:b9:40:01:3d:f8 -&gt; cron2-gentoo-i386/193.xx.xx.xx
Aug 23 09:37:24 phillip tap-udp-p2mp[60213]: cron2-gentoo-i386/193.xx.xx.xx=
 MULTI: bad source address from client [01:72:40:01:62:d7], packet dropped
Aug 23 09:37:24 phillip tap-udp-p2mp[60213]: cron2-gentoo-i386/193.xx.xx.xx=
 MULTI: Learn: 20:00:40:01:d7:d8 -&gt; cron2-gentoo-i386/193.xx.xx.xx

... which looks like "the IP header ends up where the ethernet header
should be" (every ping packet shows up as "new source address" on the
openvpn server).

I have no idea what this could be, but since we want 2.3.12 out *today*,
we'll need to back it out of 2.3 for the time being.

Lev, do you have time to investigate?

gert

</pre>
      <br>
      <fieldset class=3D"mimeAttachmentHeader"></fieldset>
      <br>
      <pre wrap=3D"">------------------------------------------------------=
------------------------
</pre>
      <br>
      <fieldset class=3D"mimeAttachmentHeader"></fieldset>
      <br>
      <pre wrap=3D"">_______________________________________________
Openvpn-devel mailing list
<a class=3D"moz-txt-link-abbreviated" href=3D"mailto:Openvpn-devel@...1466...=
urceforge.net">Openvpn-devel@lists.sourceforge.net</a>
<a class=3D"moz-txt-link-freetext" href=3D"https://lists.sourceforge.net/li=
sts/listinfo/openvpn-devel">https://lists.sourceforge.net/lists/listinfo/op=
envpn-devel</a>
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------070105040303000803040006--

