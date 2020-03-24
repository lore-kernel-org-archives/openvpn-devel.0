References: <ce155eed-2936-8d5c-33a8-36f355fa243a@...2545...>
 <20200324133539.GH1431@...1296...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <7c6025e1-03bb-d8b9-9b13-36e8aaf8c5b5@...2181...>
Date: Tue, 24 Mar 2020 14:54:18 +0100
MIME-Version: 1.0
In-Reply-To: <20200324133539.GH1431@...1296...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH] mbedTLS: Make sure TLS session survives
 move
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Tom van Leeuwen <tom.van.leeuwen@...2545...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

Hi,

On 24/03/2020 14:35, Gert Doering wrote:
> Hi,
> 
> On Tue, Mar 24, 2020 at 11:42:02AM +0100, Tom van Leeuwen wrote:
>> When an mbedTLS session is moved in move_session(), the contents of the
>> the tls_session is copied to the new session and the old session is
>> reinitialized. This tls_session contains, amongst other things, an
>> mbedtls_ssl_config and bio_ctx structure. However, the mbedtls context has
>> internal pointers to the mbedtls_ssl_config and bio_ctx. When the session
>> is moved, these internal pointers point to the reinitialized session.

Can you explain, from an higher level perspective, what real/visible
issue is this creating? i.e. do we have a crash under specific
circumstances? do we have a key exchange failure at some point?

How did you find the issue?

-- 
Antonio Quartulli

