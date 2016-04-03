References: <57016640.1060208@...277...>
	<CAEsd45QUmZu35zushUaRF+OgnqQo7925Uc9e3X7dBFLBr-XDNg@...278...>
	<57018DBA.4080302@...277...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <57019706.8080403@...2080...>
Date: Mon, 4 Apr 2016 00:19:50 +0200
MIME-Version: 1.0
In-Reply-To: <57018DBA.4080302@...277...>
Subject: Re: [Openvpn-devel] [PATCH 3/7] vlan: Add global,
 per-client 802.1q-based options
Reply-To: openvpn-devel@lists.sourceforge.net
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
To: Mike Auty <mike.auty@...277...>, "Jonathan K. Bullard" <jkbullard@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

On 03/04/16 23:40, Mike Auty wrote:
> On 03/04/16 22:10, Jonathan K. Bullard wrote:
>>
>> NAK. This should include testing for extra parameters supplied in
>> error with the options, as the rest of the option-handling code does.
>> Something like the following (for each of the three new options):
>>
>> +  else if (streq (p[0], "vlan-tagging") && !p[1])
>>
> 
> Thanks for reviewing the patches!  5:)
> 
> That should be reasonable to add in, I'll try and do that in the next
> couple of days (and try and change round my git repo so that I can keep
> the patch versions in separate branches).
> 
> Could you let me know if I should be resending all the patches for the
> next version, or just the ones that have changed?

As long as it is a change only affecting a single patch, then resending an
updated version of that patch is generally fine.

When updating patches, please ensure that the subject line states for example
"PATCH v2".  That is easily done by adding --subject-prefix="PATCH v2" to the
git command lines creating the patch.

Second detail is to add a "revision history" in the git commit log.  See
commit a24dd2e31f196c76 as an example.


-- 
kind regards,

David Sommerseth

