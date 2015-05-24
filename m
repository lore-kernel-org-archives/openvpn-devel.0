Message-ID: <5562310A.1040108@...1147...>
Date: Sun, 24 May 2015 22:14:02 +0200
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
References: <55619DC4.2020108@...1856...>
In-Reply-To: <55619DC4.2020108@...1856...>
Subject: Re: [Openvpn-devel] [PATCH] Clarify --capath option in manpage
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
To: Steffan Karger <steffan@...1856...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

On 24/05/15 11:45, Steffan Karger wrote:
> Prevent confusion as described in trac #422 by better explaining the 
> behaviour of --capath, and providing pointers to relevant openssl man 
> pages.
>
> Attached are patches for the master and release/2.3 branches.  The 
> only difference is that in the master patch, a line referencing the 
> requirement for OpenSSL 0.9.7 is removed, since master already 
> requires OpenSSL >= 0.9.8.
>

I intend to NACK this patch -  AFAIK it is *not* required to use .r0 CRL 
files with --capath.
You can run your setup perfectly fine without them (last time I checked).
However, *IF* one wants to use CRL files in combination with --capath 
then you must supply .r0 files .

JJK

