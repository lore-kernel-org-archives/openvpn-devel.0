References: <b10bce22-0b79-100f-d880-8388d23c6267@...1856...>
	<1494279878-24601-1-git-send-email-steffan@...1856...>
	<18f36661-f955-86d6-e948-755bdb401fd7@...2080...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <14275f69-821f-93a1-34b9-6f1018e741bc@...1227...>
Date: Tue, 9 May 2017 14:08:26 +0200
MIME-Version: 1.0
In-Reply-To: <18f36661-f955-86d6-e948-755bdb401fd7@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] Restore pre-NCP frame parameters for
 new sessions
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

Am 09.05.17 um 12:46 schrieb David Sommerseth:
> On 08/05/17 23:44, Steffan Karger wrote:
>> As reported in trac #879, as of the introduction of NCP we always adjust
>> the frame parameters on session negotiations, but do not reset the frame
>> state for a new session on an existing state instance.  That caused the
>> frame parameters to be reduced for each reconnect, resulting in smaller
>> and smaller packet size limits until no traffic could go through the
>> tunnel at all.  This patch resolves that omission.
> 
> 
> Only glared at the code changes, and it makes sense to me.  I'll try to
> run a few tests to see if I can reproduce this issue.  If others can
> help test this patch, that will also help tremendously - and I'll try to
> remember to add a Tested-by: tag in the commit log too for all those
> confirming this fix.
> 
>
For me this patch also fixes the issue. And the patch looks correct, so
ACK from me.

Arne


