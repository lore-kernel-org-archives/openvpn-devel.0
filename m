From: Steffan Karger <steffan.karger@...1435...>
References: <1514540857-19290-1-git-send-email-steffan.karger@...1435...>
 <201801091431.w09EVeSP070386@...2054...>
Message-ID: <c2b39501-3ec7-0c62-f1c6-96da33c46173@...1435...>
Date: Thu, 11 Jan 2018 14:55:37 +0100
MIME-Version: 1.0
In-Reply-To: <201801091431.w09EVeSP070386@...2054...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH applied] Re: travis: use clang's
 -fsanitize=address to catch more bugs
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

Hi,

On 09-01-18 15:31, Gert Doering wrote:
> ACK, makes sense.
> 
> Your patch has been applied to the master branch.

Thanks.  Can you also cherry-pick this one to release/2.4?  Because
there the clang builds are now screaming bloody murder (and sometimes
failing) because of ccache too.

-Steffan

