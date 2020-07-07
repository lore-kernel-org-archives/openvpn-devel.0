References: <E1jsoYQ-0007AZ-BF@...2487...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <050e024f-0fbb-f691-47f1-c749e2c83bf6@...2181...>
Date: Tue, 7 Jul 2020 17:55:47 +0200
MIME-Version: 1.0
In-Reply-To: <E1jsoYQ-0007AZ-BF@...2487...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH] Make openvpn --version exit with exit
 code 0
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
To: Steffan Karger <steffan.karger@...2507...>, openvpn-devel@lists.sourceforge.net

Hi,

On 07/07/2020 16:26, Steffan Karger wrote:
> For some reason, openvpn --version has since the beginning of time
> returned exit code 1. A quick sample among common unix utilities confirms
> that the rest of the world agrees with me that 0 makes more sense. Let's
> make openvpn --version exit with exit code 0 too.
> 
> Signed-off-by: Steffan Karger <steffan.karger@...2507...>

I also agree with Steffan - if --version was passed as argument than
"success" behaviour is to print the related text and exit with success.

Like he said, this is what most other unix command line tools do.

I quickly tested the patch and I can confirm it does what it says :)

Acked-by: Antonio Quartulli <a@...2181...>



-- 
Antonio Quartulli

