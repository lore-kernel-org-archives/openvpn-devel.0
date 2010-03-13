Message-ID: <4B9C1C16.8080107@...68...>
Date: Sun, 14 Mar 2010 00:13:26 +0100
From: Matthias Andree <matthias.andree@...68...>
MIME-Version: 1.0
References: <4B8ADF36.3050201@...1114...>
	<20100301105856.GY9556@...1296...>
In-Reply-To: <20100301105856.GY9556@...1296...>
Subject: Re: [Openvpn-devel]
 =?iso-8859-1?q?=5BFeedback_needed=5D=A0Fix_cross_?=
 =?iso-8859-1?q?compile_support?=
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Am 01.03.2010 11:58, schrieb Gert Doering:
> Hi,
> 
> On Sun, Feb 28, 2010 at 10:25:10PM +0100, David Sommerseth wrote:
>> I'm reviewing this patch in the patch tracker, and cannot make up my
>> mind if this is correct or not.  Can someone please advise if this is
>> something we should include or not?
>> 
>> <https://sourceforge.net/tracker/?func=detail&aid=2491190&group_id=48978&atid=454721>
> 
> I don't really understand the subtleties of autoconf and friends, but
> I can attest that the current source tree cross-compiles just fine
> (e.g. "configure --prefix=/usr --host=armv5tel-unknown-linux-gnueabi").
> 
> Something to keep in mind: changing all TARGET_* #ifdef's in the actual
> code (as opposed to just changing the configure magic) *will* generate
> lots of merge problems with the new feature branches.  Especially the
> IPv6 payload branch has lots of system dependent changes, so this part
> of the change would have to be done in parallel on multiple branches,
> causing the payload branch then to no longer apply to "base 2.1.1".
> 
> 
> For this reason, I would NOT apply this patch right now - wait for the
> development tree to stabilize, before applying a mostly-religious change
> that affects 58 (!) places in the source.

Hi Gert,

No offense, but do you think it's within objective discussion to call the patch
"mostly-religious change" (which is a non-objective comment in my book) if you
"don't really understand the subtleties of autoconf and friends"?

Diego's proposal was/is sound -- I checked it for another project of mine when
he sent a similar patch there --, and chases a cleanup in auto*, where
build/host/target relations were polished a bit.  As such, it's a desirable
update and it is good to see elsewhere in this branch that it was accepted, so
that Diego's effort wasn't wasted.

WRT practical merge concerns around TARGET_*, git knows the "rerere" sub-command
to track merge conflict resolutions (see the manual); and since the required
edits can be scripted, that could happen on the feature branches before
attempting a merge. No big deal.

Anyways, I have a bit of auto* expertise, feel free to Cc:/ping me on auto*
related proposals to openvpn.  I've only cursorily been following the increased
list traffic lately until the changed-procedure threads would have settled a
bit, and the thread didn't catch my eye right away.

Best regards

-- 
Matthias Andree

