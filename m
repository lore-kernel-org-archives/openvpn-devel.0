References: <1530633509-4959-1-git-send-email-selva.nair@...277...>
 <1531491395-29049-1-git-send-email-selva.nair@...277...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <4e0e285a-482a-700a-e359-fc8cf8c1613c@...1856...>
Date: Fri, 5 Oct 2018 11:43:37 +0200
MIME-Version: 1.0
In-Reply-To: <1531491395-29049-1-git-send-email-selva.nair@...277...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH v3] Make up/down script errors not FATAL
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
To: openvpn-devel@lists.sourceforge.net

Hi,

On 13-07-18 16:16, selva.nair@...277... wrote:
> From: Selva Nair <selva.nair@...277...>
> 
> The error is treated as a warning only if its triggered due
> to script_security < SSEC_SCRIPTS.
> 
> This helps user interfaces enforce a safer script-security setting
> without causing a FATAL error.

But does it make sense at all to accept configs that have a --up script
without a sufficiently-high script-security set?

I do agree that the current place where the code checks this not nice,
so maybe we should perform this check somewhere in the
options_postprocess_verify* functions?  That way we error out early,
instead of only when trying to execute the script.

-Steffan

