References: <20161129063843.14526-1-a@...2181...>
	<aca99453-61e3-05aa-f683-cf385a7e90f6@...1435...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <77c6f81d-c935-3639-df3d-5d21d2372f50@...1856...>
Date: Tue, 29 Nov 2016 21:32:56 +0100
MIME-Version: 1.0
In-Reply-To: <aca99453-61e3-05aa-f683-cf385a7e90f6@...1435...>
Subject: Re: [Openvpn-devel] [PATCH] reload CRL only if file was modified
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
To: openvpn-devel@lists.sourceforge.net


On 29-11-16 17:43, Steffan Karger wrote:
> Will test more thoroughly tonight (hopefully on Windows too), but have a
> lot of faith that those will succeed.

Just did this, on linux and windows, and code works as expected.  So
once you've taken care of the (minor) remarks in my previous mails, I
think this patch is good to go!

-Steffan

