References: <53533abe-e85d-7a42-49ce-465267997724@...515...>
From: debbie10t <debbie10t@...277...>
Message-ID: <217a4a52-40b8-e24e-aa7b-07a38507828f@...277...>
Date: Wed, 19 Oct 2016 16:52:48 +0100
MIME-Version: 1.0
In-Reply-To: <53533abe-e85d-7a42-49ce-465267997724@...515...>
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
Content-Type: text/plain; charset="iso-8859-15"; format="flowed"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net



On 19/10/16 14:04, Samuli Sepp=E4nen wrote:
> Hi,

>
> Three directory alternatives have been proposed:
>
> %USERPROFILE%\OpenVPN\config (current approach)
> %APPDATA%\OpenVPN\config
> %USERPROFILE%\.openvpn\config
>

I find the whole idea of "Hiding things from users"
to be an unnecessary and pointless exercise ..
Especially with regard to configuration files, which you
are specifically handing over to users by creating the
interactive service.

My Vote:
%USERPROFILE%\.openvpn\config


Regards

