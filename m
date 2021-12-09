Date: Thu, 9 Dec 2021 14:49:52 +0100 (CET)
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <150254504.743723.1639057792357@...2642...>
In-Reply-To: <20211207170211.3275837-14-arne@...1227...>
References: <20211207170211.3275837-1-arne@...1227...>
 <20211207170211.3275837-14-arne@...1227...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH 13/21] Implement optional mtu parameter
 for mssfix
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net



> Arne Schwabe <arne@...1227...> hat am 07.12.2021 18:02 geschrieben:
> 
>  
> The current mssfix parameter is a bit as it needs manual calculation of

missing word after "bit"?

> the allowable packet size and also the resulting MSS value does not take
> into account if IPv4 or IPv6 is used on the outer tunnel. The mtu parameter
> fixes both of these problem by dynamically including the real overhead.
> 
> The syntax and naming of the parater is chosen for compatiblity with OpenVPN3.

typo "parameter"

> diff --git a/doc/man-sections/link-options.rst b/doc/man-sections/link-options.rst
> index b1ae4e75a..f41c0c4f1 100644
> --- a/doc/man-sections/link-options.rst
> +++ b/doc/man-sections/link-options.rst
> @@ -110,19 +110,25 @@ the local and the remote host.
>    (:code:`p2p`). OpenVPN 2.0 introduces a new mode (:code:`server`) which
>    implements a multi-client server capability.
>  
> ---mssfix max
> +--mssfix max [mtu]

If you want to denote optional paramters (which I think makes sense, but is not
consistently done in the documentation so far), then I think it needs to be
--mssfix [max [mtu]]

>    Announce to TCP sessions running over the tunnel that they should limit
>    their send packet sizes such that after OpenVPN has encapsulated them,
>    the resulting UDP packet size that OpenVPN sends to its peer will not
>    exceed ``max`` bytes. The default value is :code:`1450`.
>  

Regards,
  Frank

--
Frank Lichtenheld

