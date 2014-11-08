Message-ID: <545E2710.5000602@...1227...>
Date: Sat, 08 Nov 2014 15:22:08 +0100
From: Arne Schwabe <arne@...1227...>
MIME-Version: 1.0
References: <1415312819-16048-1-git-send-email-steffan@...1856...>
	<545DED2C.5070002@...1856...>
In-Reply-To: <545DED2C.5070002@...1856...>
Subject: Re: [Openvpn-devel] [PATCH] Fix assertion error when using --cipher
 none
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net

On 08.11.2014 11:15, Steffan Karger wrote:
> On 06-11-14 23:26, Steffan Karger wrote:
>> Some commits ago, the cipher mode checks were cleaned up to
>> remove code duplication (and fix the issue in #471), but broke
>> '--cipher none' (reported in #473). This commit fixes that.
> Attached a v2 of this patch that removes the (inconsistent) renaming of
> the cipher_kt_mode() parameter. Otherwise this patch is the same.
>
>
ACK

Arne

