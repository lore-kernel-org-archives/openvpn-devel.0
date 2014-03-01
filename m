Message-ID: <53124C7B.5020509@...1856...>
Date: Sat, 01 Mar 2014 22:09:15 +0100
From: Steffan Karger <steffan@...1856...>
MIME-Version: 1.0
References: <1393684575-28112-1-git-send-email-steffan@...1856...>
	<20140301153416.GX16637@...1296...>
In-Reply-To: <20140301153416.GX16637@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] Clean up --show-tls output for OpenSSL
 builds
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

Hi,

On 01-03-14 16:34, Gert Doering wrote:
> On Sat, Mar 01, 2014 at 03:36:13PM +0100, Steffan Karger wrote:
>> The following two (small) patches are usability improvements.
> 
> is this master-only, or does it make sense for 2.3 as well?

Good point, I forgot to mention:
1/2 Makes sense for 2.3 too, 2.3 contains the same translation table and
the patch will also suppress useless warnings.
2/2 Makes no sense for 2.3, 2.3 does not have the default cipher list.

-Steffan

