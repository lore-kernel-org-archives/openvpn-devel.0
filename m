References: <20161026120631.15946-1-a@...2181...>
	<30247351-24a3-4314-40c5-bfb5e82f84b0@...1435...>
	<20161026124019.GE8925@...2182...>
	<2f3f0e84-38f8-3940-d9d5-5e8c99c10696@...1435...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <41f11dfb-3910-ac81-e665-d1e4fa30de0e@...1227...>
Date: Wed, 26 Oct 2016 15:30:39 +0200
MIME-Version: 1.0
In-Reply-To: <2f3f0e84-38f8-3940-d9d5-5e8c99c10696@...1435...>
Subject: Re: [Openvpn-devel] [PATCH] don't mix settings when crl-verify
 option appears more than once
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
To: Steffan Karger <steffan.karger@...1435...>, Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net



Am 26.10.16 um 14:48 schrieb Steffan Karger:
> On 26-10-16 14:40, Antonio Quartulli wrote:
>> I was planning to do the rest of the refactoring in a second patch.
>>
>> At this point I think it would make sense to reject this patch and wait for a
>> full patchset set where I will:
>>
>> 1) "fix" every inline option to be sure that we don't carry around bogus
>> settings
>> 2) switch any *_inline field to bool
>> 3) refactor the code to avoid strcmp()
>
Beware that the [[inline]] also serves as a filename and you have to add
extra logic everywhere a file name is printed.

Arne

