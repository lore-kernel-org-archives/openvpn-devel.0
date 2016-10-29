MIME-Version: 1.0
In-Reply-To: <ff9f92a3-e7ab-24bd-b715-5e6ae725cea0@...1147...>
References: <1477650469-32431-1-git-send-email-janjust@...1147...>
	<CAKuzo_ibmkh=zoEzaVCYFFkYXE0hpnOCN5VvQnP+JGdq7_+kUQ@...278...>
	<ff9f92a3-e7ab-24bd-b715-5e6ae725cea0@...1147...>
From: Selva Nair <selva.nair@...277...>
Date: Sat, 29 Oct 2016 11:03:12 -0400
Message-ID: <CAKuzo_i5NrHPVEmr2uanvDWtP7-KBph630=ZiHitLsLkC9eR1A@...278...>
Content-Type: multipart/alternative; boundary=001a114c89464259ae05400247cf
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
To: Jan Just Keijser <janjust@...1147...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a114c89464259ae05400247cf
Content-Type: text/plain; charset=UTF-8

Hi,

On Sat, Oct 29, 2016 at 9:27 AM, Jan Just Keijser <janjust@...1147...> wrote:

> That apart, NAK to this patch as its not correct
>
> I'll see if I can refactor the patch - but your suggestion to put it at
> the top of add_option did not work for me initially.


Its not about refactoring. The patch simply causes definition of an env
variable named "opt" and does not treat what follows "setenv opt" as an
option. To handle the option correctly, setenv and opt should be stripped
before the parsing starts as is done when processed from config file.

Regards,

Selva

--001a114c89464259ae05400247cf
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra">Hi,</div><div class=3D"gmail_ex=
tra"><br></div><div class=3D"gmail_extra"><div class=3D"gmail_quote">On Sat=
, Oct 29, 2016 at 9:27 AM, Jan Just Keijser <span dir=3D"ltr">&lt;<a href=
=3D"mailto:janjust@...1147..." target=3D"_blank">janjust@...1147...</a>&gt;=
</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .=
8ex;border-left:1px #ccc solid;padding-left:1ex"><span><blockquote type=3D"=
cite"><div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote=
"><div>That apart, NAK to this patch as its not correct</div>
            <br>
          </div>
        </div>
      </div>
    </blockquote></span>
    I&#39;ll see if I can refactor the patch - but your suggestion to put it
    at the top of add_option did not work for me initially.</blockquote></d=
iv><br>Its not about refactoring. The patch simply causes definition of an =
env variable named &quot;opt&quot; and does not treat what follows &quot;se=
tenv opt&quot; as an option. To handle the option correctly, setenv and opt=
 should be stripped before the parsing starts as is done when processed fro=
m config file.</div><div class=3D"gmail_extra"><br></div><div class=3D"gmai=
l_extra">Regards,</div><div class=3D"gmail_extra"><br></div><div class=3D"g=
mail_extra">Selva</div><div class=3D"gmail_extra"><br></div><div class=3D"g=
mail_extra">=C2=A0</div></div>

--001a114c89464259ae05400247cf--

