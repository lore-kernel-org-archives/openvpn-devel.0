References: <1489062192-25245-1-git-send-email-steffan.karger@...1435...>
From: Steffan Karger <steffan.karger@...1435...>
Message-ID: <11de8219-d64d-a9d0-4fa7-a8c63a8d17ff@...1435...>
Date: Thu, 9 Mar 2017 13:49:20 +0100
MIME-Version: 1.0
In-Reply-To: <1489062192-25245-1-git-send-email-steffan.karger@...1435...>
Subject: Re: [Openvpn-devel] [PATCH] Fix windows-specific format specifiers
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

On 09-03-17 13:23, Steffan Karger wrote:
> A number of printf-like functions in windows-specific code used incorrect
> format specifiers, which could potentially lead to incorrect values being
> printed.

Hm, some of these are not windows-specific, and cause problems for
non-windows builds.  Please hold your breath for a V2.

-Steffan



