MIME-Version: 1.0
References: <20200924065915.164-1-simon@...2293...>
In-Reply-To: <20200924065915.164-1-simon@...2293...>
From: Lev Stipakov <lstipakov@...277...>
Date: Thu, 24 Sep 2020 13:35:35 +0300
Message-ID: <CAGyAFMV4st-MemDgGbYaw25CkGxkML1uBkPuCVhjWKEKxbQrrA@...278...>
Subject: Re: [Openvpn-devel] [PATCH] openvpnmsica: Skip legacy TAP-Windows6
 adapters from evaluation
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: Simon Rozman <simon@...2293...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

> Legacy TAP-Windows6 adapters (marked as IF_TYPE_ETHERNET_CSMACD 0x6)
> fail to upgrade to the new driver on Windows 7: Device cannot start
> (Code 10).

Does "legacy" adapter mean the one which was built before
https://github.com/OpenVPN/tap-windows6/commit/c869bc91c2537868d012af6cf833889420350387
(merged in 10/2019) ?

I just installed 2.4.6 (released in 04/2018) on Windows 7 and upgraded
it to 2.5rc1 without any issues.

Am I missing something? Also, is it supposed to be only Windows 7 specific?

> +    OSVERSIONINFOEX osvi = { sizeof(OSVERSIONINFOEX), HIBYTE(_WIN32_WINNT_WIN8), LOBYTE(_WIN32_WINNT_WIN8) };
> +    DWORDLONG const dwlConditionMask = VerSetConditionMask(VerSetConditionMask(0, VER_MAJORVERSION, VER_GREATER_EQUAL), VER_MINORVERSION, VER_GREATER_EQUAL);
> +    BOOL bSkipLegacyAdapters = !VerifyVersionInfo(&osvi, VER_MAJORVERSION | VER_MINORVERSION, dwlConditionMask);

Cannot we use IsWindows7OrGreater() ? It should work even though
msiexec is not manifested.

> +        if (CM_Get_DevNode_Status(&node->ulStatus, &node->ulProblemNumber, devinfo_data.DevInst, 0) != CR_SUCCESS)
> +        {
> +            node->ulStatus = 0;
> +            node->ulProblemNumber = 0;
> +        }

Is this change related to the bug we're supposingly fixing? What does
it do, why is it needed?

-- 
-Lev

