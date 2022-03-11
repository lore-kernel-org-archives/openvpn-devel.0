Content-Type: multipart/alternative;
 boundary="------------ecGRiqbyb1BnNaTTYwVVtUlf"
Message-ID: <eaeb2183-ad8f-b047-51a2-22a7f188ad9e@...2663...>
Date: Fri, 11 Mar 2022 09:52:13 +0100
MIME-Version: 1.0
Content-Language: de-DE
References: <99203e85-fc9e-906e-61e2-0ab250371f1f@...2663...><CAKuzo_ioneE7-WX68GNgVE_dSK1LqoxtEOZwyoafEb7596-s+g@...278...><YipsQB6QHjkjC4/I@...1296...><CAKuzo_g3x6PDMeiDvxM303XdVLpF68xfw6AcEWgBKk6sw1ighQ@...278...>
From: Jakob Curdes <jc@...2663...>
In-Reply-To: <CAKuzo_g3x6PDMeiDvxM303XdVLpF68xfw6AcEWgBKk6sw1ighQ@...278...>
Subject: Re: [Openvpn-devel] OpenVPN Client 2FA problem with Backslash
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>, Gert Doering <gert@...1296...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------ecGRiqbyb1BnNaTTYwVVtUlf
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit


> Hi,
>
> On Thu, Mar 10, 2022 at 4:23 PM Gert Doering <gert@...1296...> wrote:
>
>     Hi,
>
>     On Thu, Mar 10, 2022 at 12:51:51PM -0500, Selva Nair wrote:
>     > I missed this follow up on the devel list. Please see my reply to
>     > openvpn-users. If @ doesnt work there is no easy fix short of
>     patching the
>     > GUI.
>
>     We're planning a 2.5.x release "some time next week" (partly prompted
>     due to the OpenSSL release on 
>
>     tuesday).  So now's a good time for GUI
>     fixes :-)
>
>
> See PR 483 <https://github.com/OpenVPN/openvpn-gui/pull/483>
>
> @Jakob Curdes <mailto:jc@...2663...>  This could be tested using 
> the CI executable here:
> https://github.com/OpenVPN/openvpn-gui/suites/5617977743/artifacts/182849130
> (for 64 bit Windows). No need to install --- just unzip into a temp 
> folder and double click on the included openvpn-gui.exe.
>
> Selva

Hello Selva, hello all,

I have tested the executable in the circumstances described earlier. I 
confirm the problem described (username/password auth succeeds, but 
second auth with 2FA data fails as the backslash in the username is not 
escaped this time) is solved using the binary provided. I also confirmed 
this in issue #483  .

Thank you all for your quick work. This will help us rolling out 2FA to 
a bunch of users!

Regards, Jakob


--------------ecGRiqbyb1BnNaTTYwVVtUlf
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><br>
    </p>
    <blockquote type="cite"
cite="mid:CAKuzo_g3x6PDMeiDvxM303XdVLpF68xfw6AcEWgBKk6sw1ighQ@...278...">
      <meta http-equiv="content-type" content="text/html; charset=UTF-8">
      <div dir="ltr">
        <div dir="ltr">Hi,</div>
        <br>
        <div class="gmail_quote">
          <div dir="ltr" class="gmail_attr">On Thu, Mar 10, 2022 at 4:23
            PM Gert Doering &lt;<a href="mailto:gert@...1296..."
              target="_blank" moz-do-not-send="true"
              class="moz-txt-link-freetext">gert@...1296...</a>&gt;
            wrote:<br>
          </div>
          <blockquote class="gmail_quote" style="margin:0px 0px 0px
            0.8ex;border-left:1px solid
            rgb(204,204,204);padding-left:1ex">Hi,<br>
            <br>
            On Thu, Mar 10, 2022 at 12:51:51PM -0500, Selva Nair wrote:<br>
            &gt; I missed this follow up on the devel list. Please see
            my reply to<br>
            &gt; openvpn-users. If @ doesnt work there is no easy fix
            short of patching the<br>
            &gt; GUI.<br>
            <br>
            We're planning a 2.5.x release "some time next week" (partly
            prompted<br>
            due to the OpenSSL release on </blockquote>
          <blockquote class="gmail_quote" style="margin:0px 0px 0px
            0.8ex;border-left:1px solid
            rgb(204,204,204);padding-left:1ex"> tuesday).  So now's a
            good time for GUI<br>
            fixes :-)<br>
            <br>
          </blockquote>
          <div><br>
          </div>
          <div>See PR <a
              href="https://github.com/OpenVPN/openvpn-gui/pull/483"
              moz-do-not-send="true">483</a></div>
          <div><br>
          </div>
          <div><a class="gmail_plusreply"
              id="m_-5532055924127106883plusReplyChip-0"
              href="mailto:jc@...2663..." target="_blank"
              moz-do-not-send="true">@Jakob Curdes</a>  This could be
            tested using the CI executable here: </div>
          <div><a
href="https://github.com/OpenVPN/openvpn-gui/suites/5617977743/artifacts/182849130"
              target="_blank" moz-do-not-send="true"
              class="moz-txt-link-freetext">https://github.com/OpenVPN/openvpn-gui/suites/5617977743/artifacts/182849130</a></div>
          <div>(for 64 bit Windows). No need to install --- just unzip
            into a temp folder and double click on the included
            openvpn-gui.exe.</div>
          <div><br>
          </div>
          <div>Selva</div>
        </div>
      </div>
    </blockquote>
    <p>Hello Selva, hello all, <br>
    </p>
    <p>I have tested the executable in the circumstances described
      earlier. I confirm the problem described (username/password auth
      succeeds, but second auth with 2FA data fails as the backslash in
      the username is not escaped this time) is solved using the binary
      provided. I also confirmed this in issue #483  . <br>
    </p>
    <p>Thank you all for your quick work. This will help us rolling out
      2FA to a bunch of users!</p>
    <p>Regards, Jakob <br>
    </p>
    <p><br>
    </p>
    <div class="moz-signature"></div>
  </body>
</html>

--------------ecGRiqbyb1BnNaTTYwVVtUlf--

