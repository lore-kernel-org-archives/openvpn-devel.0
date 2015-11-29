References: <CAEsd45QjsjNDWFkoHG2O0ycO2pNGxj115TH+SLiUD__jf=WWpQ@...278...>
	<1448823144-1497-1-git-send-email-arne@...1227...>
	<CAKuzo_gG40h6JOyp4fAw39u1uK+6Zs68XSVHAABihtYEtfGrEw@...278...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <565B50C5.7020704@...1227...>
Date: Sun, 29 Nov 2015 20:23:49 +0100
MIME-Version: 1.0
In-Reply-To: <CAKuzo_gG40h6JOyp4fAw39u1uK+6Zs68XSVHAABihtYEtfGrEw@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Reflect enable-password-save change in
 documentation
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Selva Nair <selva.nair@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Am 29.11.15 um 20:09 schrieb Selva Nair:
> Hi,
> 
> On Sun, Nov 29, 2015 at 1:52 PM, Arne Schwabe <arne@...1227...
> <mailto:arne@...1227...>> wrote:
> 
>     --- a/doc/openvpn.8
>     +++ b/doc/openvpn.8
>     @@ -3800,10 +3800,7 @@ over the client's routing table.
>      Authenticate with server using username/password.
>      .B up
>      is a file containing username/password on 2 lines. If the
>     -password line is missing, OpenVPN will prompt for one. (Note: OpenVPN
>     -will only read passwords from a file if it has been built
>     -with the \-\-enable\-password\-save configure option, or on Windows
>     -by defining ENABLE_PASSWORD_SAVE in win/settings.in
>     <http://settings.in>).
>     +password line is missing, OpenVPN will prompt for one.
> 
> 
> There is a similar description relating to --askpass . That may be
> deleted too.

Hm but the paragraph of --askpass is not related to
--enable-password-save, or do I miss something?

Arne


