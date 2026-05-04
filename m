Message-ID: <971e8751-8551-4d9c-8c2f-398d17b368b4@...2108...>
Date: Mon, 4 May 2026 13:21:43 +0200
MIME-Version: 1.0
References: <1777879369.971087242@...3037...>
From: David Sommerseth <dazo+openvpn@...2108...>
Content-Language: en-US
In-Reply-To: <1777879369.971087242@...3037...>
Subject: Re: [Openvpn-devel] Fwd: [PATCH] netcfg: handle ParseFromString
 result for protobuf 34 (nodiscard)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: =?UTF-8?B?0JTQvNC40YLRgNC40Lkg0KDQvtC80LDQvdC+0LI=?= <dromanov2002@...450...>
Cc: Openvpn-devel@lists.sourceforge.net

On 04/05/2026 09:22, Дмитрий Романов via Openvpn-devel wrote:
[...]
>  
> Building openvpn3-linux v26 with protobuf 34.x and GCC 15 fails in
> netcfg-dco.cpp: google::protobuf::MessageLite::ParseFromString is now
> [[nodiscard]], and the project builds with -Werror, so ignoring the
> return value becomes a hard error (-Werror=unused-result).
>  
> Check the return value and throw NetCfgException on parse failure,
> consistent with other error handling in this file.
>  
> This should fix distributions that already ship protobuf 34 (e.g. Arch).
>  
> If there is an existing issue on Codeberg for this (e.g. related to
> nodiscard / protobuf 34), please link this patch there.
>  
> Signed-off-by: Dmitriy Romanov <dromanov2002@...450...
> <mailto:dromanov2002@...450...>>
>  

Hi,

Thanks a lot for this patch.  This issue was reported quite recently
while digging into some other issues.  It is being tracked in Codeberg
issue #96: <https://codeberg.org/OpenVPN/openvpn3-linux/issues/96>

I'm following up on that ticket closely and will provide more updates in
the days to come.


-- 
kind regards,

David Sommerseth


