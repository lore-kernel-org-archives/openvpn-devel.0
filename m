Message-ID: <f9a29ad2-b3d5-c885-ba24-9ed4a706c550@...1227...>
Date: Thu, 14 Jul 2022 17:28:56 +0200
MIME-Version: 1.0
Content-Language: en-GB
References: <20220707035151.25469-1-selva.nair@...277...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <20220707035151.25469-1-selva.nair@...277...>
Subject: Re: [Openvpn-devel] [PATCH] Fix crash in xkey-provider in msvc
 builds
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
To: selva.nair@...277..., openvpn-devel@lists.sourceforge.net

Am 07.07.22 um 05:51 schrieb selva.nair@...277...:
> From: Selva Nair <selva.nair@...277...>
> 
> The function signature for xkey_load_generic_key had
> function pointers defined as function types that seems
> to work in gcc but not in msvc.
> 
> Fix it by changing the function signatures to what was
> intended.
> Also revert part of commit 627d1a3d28638... as that work-
> around should be no longer required.
> 
> Reported by: Lev Stipakov https://github.com/lstipakov
>

I am surprised that this commit is not a noop but it is "more" correct 
this. So without any idea if this actually fixes Windows or not, I 
approve this commit on the basis of a cosmetic fix that is actually right.

Arne

