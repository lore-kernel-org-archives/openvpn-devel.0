MIME-Version: 1.0
In-Reply-To: <20151106211238.GB24952@...1296...>
References: <1446663578-14471-1-git-send-email-selva.nair@...277...>
	<201511062108.tA6L8x2n034456@...2054...>
	<20151106211238.GB24952@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Sat, 7 Nov 2015 00:01:40 -0500
Message-ID: <CAKuzo_h83eRood+NuzD=tDWdirXg996tcfegsGT32tFhdJ=wTw@...278...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Fix termination when
	windows suspends/sleeps
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi,

On Fri, Nov 6, 2015 at 4:12 PM, Gert Doering <gert@...1296...> wrote:
> On Fri, Nov 06, 2015 at 10:08:59PM +0100, Gert Doering wrote:
>> ACK.  Explanation makes sense, logs and testers demonstrate that it indeed
>> fixes a significant problem, and the code is sane :-) - thanks.
>>
>> Your patch has been applied to the master and release/2.3 branch.
>>
>> commit ea66a2b5cdb21422139c421b4d3733e1c1c3937e (master)
>> commit 0d4ba251879c702b9474e26ff73a4f559d922d4f (release/2.3)
>
> Uh, and because I forgot to mention it - Samuli's buildbot will build a
> windows snapshot from git master containing this, and it will be part
> of 2.3.9 when we release this (no timeline yet).

Thanks.

Speaking of the windows installer, the GUI needs a small change to
play nice with this patch. Else the GUI will end up killing openvpn on
resume.. Not sure where to send patches for the GUI.

Selva

