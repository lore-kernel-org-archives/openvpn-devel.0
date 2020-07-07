References: <20200707121615.15736-1-arne@...1227...>
 <20200707121615.15736-3-arne@...1227...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <0196782f-a9d1-da2a-58c6-9515a8ae5e11@...2181...>
Date: Tue, 7 Jul 2020 18:06:25 +0200
MIME-Version: 1.0
In-Reply-To: <20200707121615.15736-3-arne@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH 1/3] Simplify
 multi_connection_established.
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

On 07/07/2020 14:16, Arne Schwabe wrote:
> Instead of having the whole function as
> 
>     if (x) { func }
> 
> do
> 
>    if (!x) func

I guess this commit message needs some love? You probably meant:

Instead of..

	if (x) { func }

do

	if (!x) return;
	func


At least, this is what the patch does :-)

> 
> Due to the whitespace changes in the function body this patch looks
> very strange. Ignoring whitespace makes the diff look sane.
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>

I am super-pro this style.

It makes the whole function easier to read and saves a lot of horizontal
spaces by killing one level of indentation.

Reviewing this patch with "git show -w" makes it super obvious.

No functional change included, the patch is just reverting the top
condition and returning right away.

Stared at the code and compile-tested. (but please fix the commit
message before merging)

Acked-by: Antonio Quartulli <a@...2181...>


-- 
Antonio Quartulli

