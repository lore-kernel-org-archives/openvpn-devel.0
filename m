References: <1477650469-32431-1-git-send-email-janjust@...1147...>
	<CAKuzo_ibmkh=zoEzaVCYFFkYXE0hpnOCN5VvQnP+JGdq7_+kUQ@...278...>
From: Jan Just Keijser <janjust@...1147...>
Message-ID: <ff9f92a3-e7ab-24bd-b715-5e6ae725cea0@...1147...>
Date: Sat, 29 Oct 2016 15:27:57 +0200
MIME-Version: 1.0
In-Reply-To: <CAKuzo_ibmkh=zoEzaVCYFFkYXE0hpnOCN5VvQnP+JGdq7_+kUQ@...278...>
Content-Type: multipart/alternative;
	boundary="------------167332F46A5467F057BA660B"
Subject: Re: [Openvpn-devel] [PATCH] Allow "setenv opt" to be pushed from
 server to client
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------167332F46A5467F057BA660B
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 28/10/16 19:50, Selva Nair wrote:
> Hi,
>
> On Fri, Oct 28, 2016 at 6:27 AM, Jan Just Keijser <janjust@...1147... 
> <mailto:janjust@...1147...>> wrote:
>
>     ---
>      src/openvpn/options.c | 9 ++++++++-
>      1 file changed, 8 insertions(+), 1 deletion(-)
>
>
> As Arne pointed out the utility of allowing setenv opt in push is 
> questionable. "setenv opt bad-option" in config file logs a warning 
> and continues. "push bad-option" logs an error and continues. The end 
> result is that both avoids fatal errors with unrecognized/unknown 
> options.
>

the desired effect of the patch is to not print an ERROR but a warning 
instead. For a sysadmin of a large scale deployment *any* method to 
reduce the number of false errors/warnings is an advantage.
Also, I see no reason to NOT add this patch, as it does not introduce 
any vulnerabilities, but it only makes the config file behaviour versus 
"pushed" behaviour more consistent. Abusing "setenv" to add an optional 
option to a config file is a kludge at any rate - might as well make the 
kludge pushable ;)


> That apart, NAK to this patch as its not correct
>
I'll see if I can refactor the patch - but your suggestion to put it at 
the top of add_option did not work for me initially.

JJK

--------------167332F46A5467F057BA660B
X-MIME-Autoconverted: from 8bit to quoted-printable by
	outgoing1-ams.mf.surf.net id u9TDS3c7006322
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<html>
  <head>
    <meta content=3D"text/html; charset=3Dutf-8" http-equiv=3D"Content-Type=
">
  </head>
  <body bgcolor=3D"#FFFFFF" text=3D"#000000">
    <div class=3D"moz-cite-prefix">Hi,<br>
      <br>
      On 28/10/16 19:50, Selva Nair wrote:<br>
    </div>
    <blockquote
cite=3D"mid:CAKuzo_ibmkh=3DzoEzaVCYFFkYXE0hpnOCN5VvQnP+JGdq7_+kUQ@...278..."
      type=3D"cite">
      <div dir=3D"ltr">
        <div class=3D"gmail_extra">Hi,</div>
        <div class=3D"gmail_extra"><br>
          <div class=3D"gmail_quote">On Fri, Oct 28, 2016 at 6:27 AM, Jan
            Just Keijser <span dir=3D"ltr">&lt;<a moz-do-not-send=3D"true"
                href=3D"mailto:janjust@...1147..." target=3D"_blank">janjus=
t@...1147...</a>&gt;</span>
            wrote:<br>
            <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px
0.8ex;border-left-width:1px;border-left-color:rgb(204,204,204);border-left-=
style:solid;padding-left:1ex">
              <div id=3D"m_9136747121534352gmail-:1ty"
                class=3D"m_9136747121534352gmail-a3s
                m_9136747121534352gmail-aXjCH
                m_9136747121534352gmail-m1580ad8799e1f731">---<br>
                =C2=A0src/openvpn/options.c | 9 ++++++++-<br>
                =C2=A01 file changed, 8 insertions(+), 1 deletion(-)<br>
                <br>
              </div>
            </blockquote>
            <div><br>
            </div>
            <div>As Arne pointed out the utility of allowing setenv opt
              in push is questionable. "setenv opt bad-option" in config
              file logs a warning and continues. "push bad-option" logs
              an error and continues. The end result is that both avoids
              fatal errors with unrecognized/unknown options.=C2=A0</div>
            <div><br>
            </div>
          </div>
        </div>
      </div>
    </blockquote>
    <br>
    the desired effect of the patch is to not print an ERROR but a
    warning instead. For a sysadmin of a large scale deployment *any*
    method to reduce the number of false errors/warnings is an
    advantage.<br>
    Also, I see no reason to NOT add this patch, as it does not
    introduce any vulnerabilities, but it only makes the config file
    behaviour versus "pushed" behaviour more consistent. Abusing
    "setenv" to add an optional option to a config file is a kludge at
    any rate - might as well make the kludge pushable ;)<br>
    <br>
    <br>
    <blockquote
cite=3D"mid:CAKuzo_ibmkh=3DzoEzaVCYFFkYXE0hpnOCN5VvQnP+JGdq7_+kUQ@...278..."
      type=3D"cite">
      <div dir=3D"ltr">
        <div class=3D"gmail_extra">
          <div class=3D"gmail_quote">
            <div>That apart, NAK to this patch as its not correct</div>
            <br>
          </div>
        </div>
      </div>
    </blockquote>
    I'll see if I can refactor the patch - but your suggestion to put it
    at the top of add_option did not work for me initially.<br>
    <br>
    JJK<br>
  </body>
</html>

--------------167332F46A5467F057BA660B--

