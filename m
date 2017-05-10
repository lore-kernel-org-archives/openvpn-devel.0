MIME-Version: 1.0
In-Reply-To: <9cc5162b-d81b-9286-e715-e6c7d807385d@...277...>
References: <20170504173605.8269-1-valdikss@...277...>
	<CAKuzo_hKv+0LTi-pNh8xGMNTazgUjhXSkw2ZPGo0KDQ0SgsOHA@...278...>
	<9cc5162b-d81b-9286-e715-e6c7d807385d@...277...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 10 May 2017 12:40:41 -0400
Message-ID: <CAKuzo_hw3A1tAmqq_OQWgnrEyn2FSB9_T1ME5+TnrDDmkv0eXg@...278...>
Content-Type: multipart/alternative; boundary=001a11403b5045737d054f2e2379
Subject: Re: [Openvpn-devel] [PATCH] Set a low interface metric for tap
 adapter when block-outside-dns is in use
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: ValdikSS <valdikss@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a11403b5045737d054f2e2379
Content-Type: text/plain; charset=UTF-8

On Wed, May 10, 2017 at 12:08 PM, ValdikSS <valdikss@...277...> wrote:

>
> InitializeIpInterfaceEntry() is missing in all but very recent mingw32
> versions
> (their commit logs show it was added in early 2015) so we may need
> to declare it in block_dns.c. I use Debian jessie (8.7) -- mingw gcc 4.9.1
> and its
> not there. I believe Samuli's build system uses an even older version.
>
>
> I don't know how to do that correctly. Can you please help me?



In block-dns.c where "WFP-related defines and GUIDs not in mingw32" are
defined, add this

VOID NETIOAPI_API_
InitializeIpInterfaceEntry(PMIB_IPINTERFACE_ROW Row );

Do a test build for 32 bit to see now this function compiles without
warnings
and links without errors. 32 bit is a more stringent test because only in
this
case the linker will fail to find stdcall functions without proper
declarations.

That should be it.

Selva

--001a11403b5045737d054f2e2379
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Wed, May 10, 2017 at 12:08 PM, ValdikSS <span dir=3D"ltr">&lt;<a href=3D=
"mailto:valdikss@...277..." target=3D"_blank">valdikss@...277...</a>&gt;</s=
pan> wrote:<br><blockquote style=3D"margin:0px 0px 0px 0.8ex;border-left:1p=
x solid rgb(204,204,204);padding-left:1ex" class=3D"gmail_quote"><span clas=
s=3D"m_4209327532875772628gmail-"><blockquote type=3D"cite"><div dir=3D"ltr=
"><div><div class=3D"gmail_extra"><div class=3D"gmail_quote"><div><br>
              </div>
              <div>InitializeIpInterfaceEntry() is missing in all but
                very recent mingw32 versions<br>
              </div>
              <div>(their commit logs show it was added in early 2015)
                so we may need</div>
              <div>to declare it in block_dns.c. I use Debian jessie
                (8.7) -- mingw gcc 4.9.1 and its<br>
              </div>
              <div>not there. I believe Samuli&#39;s build system uses an
                even older version.</div>
            </div>
          </div>
        </div>
      </div>
    </blockquote>
    <br></span>
    I don&#39;t know how to do that correctly. Can you please help me?</blo=
ckquote></div><br><br></div><div class=3D"gmail_extra">In block-dns.c where=
 &quot;WFP-related defines and GUIDs not in mingw32&quot; are defined, add =
this<br><br>VOID
=20=20=20=20=20=20
=20=20=20=20=20=20
=20=20=20=20=20=20=20=20
        NETIOAPI_API_
=20=20=20=20=20=20
=20=20=20=20=20=20
=20=20=20=20=20=20=20=20
        <br>InitializeIpInterfaceEntry(<wbr>PMIB_IPINTERFACE_ROW Row
=20=20=20=20=20=20
=20=20=20=20=20=20
=20=20=20=20=20=20=20=20
            );<br><br></div><div class=3D"gmail_extra">Do a test build for =
32 bit to see now this function compiles without warnings<br>and links with=
out errors. 32 bit is a more stringent test because only in this<br>case th=
e linker will fail to find stdcall functions without proper declarations.<b=
r><br></div><div class=3D"gmail_extra">That should be it.<br><br></div><div=
 class=3D"gmail_extra">Selva<br></div></div>

--001a11403b5045737d054f2e2379--

