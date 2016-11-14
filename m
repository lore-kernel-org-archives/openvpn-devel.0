References: <1476996158-5390-1-git-send-email-davids@...515...>
	<1478950738-12861-1-git-send-email-davids@...515...>
	<e7f7340f-947e-ec15-37bf-9db1fb33ff11@...277...>
	<44a5aeb9-1fc1-ebd9-960e-cbea6680a8af@...2080...>
From: debbie10t <debbie10t@...277...>
Message-ID: <78424bc1-4d11-45b2-6532-bfff2c355620@...277...>
Date: Mon, 14 Nov 2016 14:06:39 +0000
MIME-Version: 1.0
In-Reply-To: <44a5aeb9-1fc1-ebd9-960e-cbea6680a8af@...2080...>
Subject: Re: [Openvpn-devel] [PATCH v2] systemd: Improve the systemd unit
 files
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
To: openvpn-devel@lists.sourceforge.net



On 14/11/16 11:02, David Sommerseth wrote:
> On 12/11/16 14:48, debbie10t wrote:
>>
>>
>> On 12/11/16 11:38, David Sommerseth wrote:

>>> +ExecStart=/usr/sbin/openvpn --suppress-timestamps --nobind --config %i.conf

>>> +ExecStart=/usr/sbin/openvpn --status %t/openvpn-server/status-%i.log --status-version 2 --suppress-timestamps --config %i.conf

>> Out of curiosity, is there a reason to put --config last ?
>
> Yes, that is to allow a sys-admin to easily change our defaults without
> modifying the unit file.

Um .. How ? .. I have not read anything which says this,
A page explaining what you mean would be of great help.

And related .. you cannot override --suppress-timestamps,
once it is set it cannot be unset. IFAIK

Thanks



