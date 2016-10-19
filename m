MIME-Version: 1.0
In-Reply-To: <7e5a1e02-9e3c-7386-ac77-d961ac2081af@...515...>
References: <53533abe-e85d-7a42-49ce-465267997724@...515...>
	<44f51d16-5251-e257-263d-375d8e01abcb@...1227...>
	<CAKuzo_ix8a-LDv0tQXk3GoAQ_VAkRAO4CRmz5di0_QM-CuiXbA@...278...>
	<7e5a1e02-9e3c-7386-ac77-d961ac2081af@...515...>
From: Steffan Karger <steffan@...1856...>
Date: Wed, 19 Oct 2016 17:17:52 +0200
Message-ID: <CAA1AbxKVxTqAD9W5NdgvQuJezO550EMMbghn-P=m2v_3ap8jyQ@...278...>
Subject: Re: [Openvpn-devel] Proper location for user-specific OpenVPN
 configuration files used by OpenVPN-GUI?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: =?UTF-8?Q?Samuli_Sepp=C3=A4nen?= <samuli@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

On 19 October 2016 at 17:14, Samuli Sepp=C3=A4nen <samuli@...515...> wrote:
> SviMik had a very good point against using %APPDATA%: it is a hidden
> folder. At least on Windows 7 it seems to be hidden at the filesystem
> level, because no tools seem to see it. However, doing a
>
>    cd $HOME\Appdata
>
> in Powershell will work, so the directory _is_ there even though it is
> invisble.
>
> I don't think we should put the configuration files into folder people
> will not find without extra tinkering.

Maybe add an 'open config folder' button/link to openvpn-gui?

-Steffan

