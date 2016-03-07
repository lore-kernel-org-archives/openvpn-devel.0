References: <2BE9E186EE9A49CCA063BEC9E3E38F20@...2089...>
	<CAKuzo_iBQUDyT6fqygSOn==xAts1i7UsyiATaZhB6e8auSkP1Q@...278...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <56DDA0D0.1090107@...1227...>
Date: Mon, 7 Mar 2016 16:40:00 +0100
MIME-Version: 1.0
In-Reply-To: <CAKuzo_iBQUDyT6fqygSOn==xAts1i7UsyiATaZhB6e8auSkP1Q@...278...>
Content-Type: multipart/alternative;
	boundary="------------050608040606020408090800"
Subject: Re: [Openvpn-devel] Samsung Galaxy S6 to android 6.0.1 powersave
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>, Debbie Tent <debbie10t@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>, "openvpn users list (openvpn-users@lists.sourceforge.net)" <openvpn-users@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------050608040606020408090800
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit



Am 07.03.16 um 16:28 schrieb Selva Nair:
> Hi,
>
> On Mon, Mar 7, 2016 at 9:55 AM, <debbie10t@...277...
> <mailto:debbie10t@...277...>> wrote:
>
>     An interesting tid-bit about Samsung Galaxy S6 to android 6.0.1
>     and OpenVPN Connect
>
>     https://forums.openvpn.net/post59478.html#p59478
>
>
> Sounds, suspiciously similar to the sleep-resume issue we had on
> windows.. The interface probably suspends and openvpn exits?
>
In this case that is again some Samsung "optmization". If there is one
manufacture of Android that consistently breaks things it is Samsung. I
have no idea what new idea they now had to break the VPNService when
combined with powersaving features or if OpenVPN Connect is doing
something wrong but normally the app is notified by an onRevoke call
before the tun device is closed.

Arne

--------------050608040606020408090800
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=windows-1252"
      http-equiv="Content-Type">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <br>
    <br>
    <div class="moz-cite-prefix">Am 07.03.16 um 16:28 schrieb Selva
      Nair:<br>
    </div>
    <blockquote
cite="mid:CAKuzo_iBQUDyT6fqygSOn==xAts1i7UsyiATaZhB6e8auSkP1Q@...278..."
      type="cite">
      <div dir="ltr">
        <div class="gmail_extra">Hi,</div>
        <div class="gmail_extra"><br>
        </div>
        <div class="gmail_extra">
          <div class="gmail_quote">On Mon, Mar 7, 2016 at 9:55 AM, <span
              dir="ltr">&lt;<a moz-do-not-send="true"
                href="mailto:debbie10t@...277..." target="_blank">debbie10t@...277...</a>&gt;</span>
            wrote:<br>
            <blockquote class="gmail_quote" style="margin:0 0 0
              .8ex;border-left:1px #ccc solid;padding-left:1ex">
              <div style="overflow:hidden">An interesting tid-bit about
                Samsung Galaxy S6 to android 6.0.1<br>
                and OpenVPN Connect<br>
                <br>
                <a moz-do-not-send="true"
                  href="https://forums.openvpn.net/post59478.html#p59478"
                  rel="noreferrer" target="_blank">https://forums.openvpn.net/post59478.html#p59478</a></div>
            </blockquote>
          </div>
          <br>
          Sounds, suspiciously similar to the sleep-resume issue we had
          on windows.. The interface probably suspends and <span><span
              class="" id=":5yy.1" tabindex="-1">openvpn</span></span>
          exits?</div>
        <div class="gmail_extra"><br>
        </div>
      </div>
    </blockquote>
    In this case that is again some Samsung "optmization". If there is
    one manufacture of Android that consistently breaks things it is
    Samsung. I have no idea what new idea they now had to break the
    VPNService when combined with powersaving features or if OpenVPN
    Connect is doing something wrong but normally the app is notified by
    an onRevoke call before the tun device is closed.<br>
    <br>
    Arne<br>
  </body>
</html>

--------------050608040606020408090800--

