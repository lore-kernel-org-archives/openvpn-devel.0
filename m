Message-ID: <836b2603-38df-adea-c7c5-b5d1dfa8a97f@...1227...>
Date: Wed, 13 Jul 2022 13:43:35 +0200
MIME-Version: 1.0
Content-Language: en-GB
References: <20220713083404.13227-1-kprovost@...2661...>
 <20220713083404.13227-2-kprovost@...2661...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <20220713083404.13227-2-kprovost@...2661...>
Subject: Re: [Openvpn-devel] [PATCH] Handle exceeding 'max-clients'
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Kristof Provost <kprovost@...2661...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

Am 13.07.22 um 10:34 schrieb Kristof Provost via Openvpn-devel:
> From: Kristof Provost <kp@...1376...>
> 
> If 'max-clients' is set multi_create_instance() can return NULL (for any
> client that would take us over the client limit).
> 
> If mi is NULL we don't add it to the hash map, but we do potentially
> dereference it to increment the session count.
> Do not attempt to do so if 'mi == NULL'.

Oops. This patch also becomes much easier to review with ignoring 
whitespace. Then the change is just moving the }

Acked-By: Arne Schwabe <arne@...2682...>

