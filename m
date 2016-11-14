References: <1476996158-5390-1-git-send-email-davids@...515...>
	<1478950738-12861-1-git-send-email-davids@...515...>
	<e7f7340f-947e-ec15-37bf-9db1fb33ff11@...277...>
	<44a5aeb9-1fc1-ebd9-960e-cbea6680a8af@...2080...>
	<78424bc1-4d11-45b2-6532-bfff2c355620@...277...>
	<f1f52ba6-4b2d-bf9a-ae71-38004755802a@...2080...>
From: debbie10t <debbie10t@...277...>
Message-ID: <9dd50ca0-56eb-88e8-821d-93a56dcdaf34@...277...>
Date: Mon, 14 Nov 2016 16:46:41 +0000
MIME-Version: 1.0
In-Reply-To: <f1f52ba6-4b2d-bf9a-ae71-38004755802a@...2080...>
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



On 14/11/16 14:46, David Sommerseth wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> On 14/11/16 15:06, debbie10t wrote:
>>
>>
>> On 14/11/16 11:02, David Sommerseth wrote:
>>> On 12/11/16 14:48, debbie10t wrote:
>>>>
>>>>
>>>> On 12/11/16 11:38, David Sommerseth wrote:
>>
>>>>> +ExecStart=/usr/sbin/openvpn --suppress-timestamps --nobind
>>>>> --config %i.conf
>>
>>>>> +ExecStart=/usr/sbin/openvpn --status
>>>>> %t/openvpn-server/status-%i.log --status-version 2
>>>>> --suppress-timestamps --config %i.conf
>>
>>>> Out of curiosity, is there a reason to put --config last ?
>>>
>>> Yes, that is to allow a sys-admin to easily change our defaults
>>> without modifying the unit file.
>>
>> Um .. How ? .. I have not read anything which says this, A page
>> explaining what you mean would be of great help.
>
> As a massive example, you can do this:
>
>  openvpn --config common.conf --config --crypto.conf --config tun0.conf
>
> OpenVPN will first load and set everything in common.conf.  Then
> it will load crypto.conf, and it can overwrites anything common.conf
> have already set, and at last tun0.conf can override anything set in
> both common.conf and crypto.conf.

Ahh .. I had not thought to pass things that way !
So this does make good sense. (ACK)

> - -- [pseudo code in pythonish] --------------

Ahh .. python-ish, or as i like to call it uroboros.
It's on my wish list.


> I don't think we have any other documentation explicitly mentioning
> this.  I learnt these tricks when doing the technical review for the
> "OpenVPN 2 Cookbook", and then later on starting to read the option
> parser code in option.c in more detail.

Good call !


>
>
>> And related .. you cannot override --suppress-timestamps, once it
>> is set it cannot be unset. IFAIK
>
> You're right about --suppress-timestamps, as there exist no option to
> reverse this one.  There are a few other scenarios where this is true
> as well, like --nobind and --status (it cannot be disabled, only
> modified to a different status file).  But the list is far shorter
> than what it was.
>
> I see that can be annoying for people insisting on using --log.  But
> in this case I would rather recommend using the systemd journal
> directly, that will cover most use cases and you have far better
> control to look/grep through logs using search and range options to
> journalctl.  And if that's not good enough, the systemd unit files we
> ship are to be placed under /usr/lib/systemd/system/.  Currently they
> can easily copy our unit file from there to /etc/systemd/system,
> remove the --suppress-timestamp and be happy.  If this turns out to be
> a bigger issue for the majority of users, we need to see which other
> options we have.  Right now, I don't see this as a big issue though.

Agreed, (ACK) .. plus these will be new unit files requiring the extra
step of systemctl'ing openvpn/{server/client} directory.


Regards

