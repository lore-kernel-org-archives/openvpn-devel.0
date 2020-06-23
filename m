References: <20200622113022.23047-1-davids@...515...>
 <CAKuzo_g7QxVL90ikT57H6b4+St2c860us6S3cN_6jbfeHujpzw@...278...>
From: Dmitry Melekhov <dm@...1823...>
Message-ID: <a1cfd42d-e371-187a-55c2-f14a3a986b34@...1823...>
Date: Tue, 23 Jun 2020 08:16:28 +0400
MIME-Version: 1.0
In-Reply-To: <CAKuzo_g7QxVL90ikT57H6b4+St2c860us6S3cN_6jbfeHujpzw@...278...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH] systemd: Change the default cipher to
 AES-256-GCM for server configs
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

22.06.2020 20:58, Selva Nair пишет:
> +*WARNING*    This MAY break configurations where the client uses
> +                ``--disable-occ`` feature where the ``--cipher`` has
> +                not been explicitly configured on both client and
> +                server side.  It is recommended to remove the ``--disable-occ``
> +                option*or*  explicitly add ``--cipher AES-256-GCM`` on the
> +                client side if ``--disable-occ`` is strictly needed.

Well, may be it is possible to add support for setting cipher in ccd

as it was possible before 2.4.9 using patch from here

https://community.openvpn.net/openvpn/ticket/845

?


Thank you!




