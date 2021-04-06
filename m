References: <20210406162518.4075-1-arne@...1227...>
 <20210406162518.4075-3-arne@...1227...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <357b33d1-bf1a-e13e-1d09-da63c97708f9@...2181...>
Date: Tue, 6 Apr 2021 23:12:31 +0200
MIME-Version: 1.0
In-Reply-To: <20210406162518.4075-3-arne@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH 3/5] Remove a number of checks for
 functions/headers that are always present
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

Hi,

On 06/04/2021 18:25, Arne Schwabe wrote:
> For the unlink function we actually have code that just ignores
> the unlink call if the unlink function is not present. But all
> platforms should have an unlink function.
> 
> This also removes all conditionals check for the headers that
> belong to the C99 standard library header list
> (https://en.cppreference.com/w/c/header).
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>

The non-windows part passed my compile-tests.
Overall I like the idea of getting rid of quite some legacy.

Cheers,


-- 
Antonio Quartulli

