Date: Fri, 3 Dec 2021 17:24:14 +0100 (CET)
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <288873647.296598.1638548654617@...2642...>
In-Reply-To: <20211202135124.2598645-1-arne@...1227...>
References: <20211202135124.2598645-1-arne@...1227...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH] Adjust cipher-negotiation.rst with
 compat-mode changes
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



> Arne Schwabe <arne@...1227...> hat am 02.12.2021 14:51 geschrieben:
> -OpenVPN 2.5 will only allow the ciphers specified in ``--data-ciphers``. To ensure
> -backwards compatibility also if a cipher is specified using the ``--cipher`` option
> -it is automatically added to this list. If both options are unset the default is
> -:code:`AES-256-GCM:AES-128-GCM`. In 2.6 and later the default is changed to
> +OpenVPN 2.5 and higher will only allow the ciphers specified in ``--data-ciphers``.

"and later" instead of "and higher" to be consistent?

> + If ``--data-ciphers`` is not set the default is :code:`AES-256-GCM:AES-128-GCM`.
> +In 2.6 and later the default is changed to
>  :code:`AES-256-GCM:AES-128-GCM:CHACHA20-POLY1305` when Chacha20-Poly1305 is available.
>  
> +For backwards compatibility OpenVPN 2.6.0 and later with ``--compat-mode 2.4.x``
> +(or lower) or OpenVPN 2.5.x will automatically add a cipher specified using the

"and OpenVPN 2.5" instead of "or" sounds better, I think. Why the ".x" here?

> +``--cipher`` option to this list.
> +

Regards,
  Frank

--
Frank Lichtenheld

