From: fragmentux <fragmentux@...277...>
References: <f2f9f587-64fb-2ce6-4a08-9d7bf99b2f66@...277...>
 <90123c98-2ed6-2f0b-7bff-a7b73089062c@...277...>
 <05d65c98-1917-dfda-48c4-534e83bc92a3@...277...>
Message-ID: <1b0ce2b6-caf5-e217-2813-9f57485647f7@...277...>
Date: Thu, 28 Sep 2017 13:16:54 +0100
MIME-Version: 1.0
In-Reply-To: <05d65c98-1917-dfda-48c4-534e83bc92a3@...277...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] suggestion: --verb 0 minor change
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

SF Bounced this .. resending.

On 27/09/17 15:31, fragmentux wrote:
> 
> 
> On 27/09/17 14:47, fragmentux wrote:
>>
>>
>> On 27/09/17 14:36, fragmentux wrote:
>>> Hi,
>>>
>>> I just upgraded a bunch of clients to 2.4.4 and although I was fairly
>>> sure they all started using the upgraded version I was not totally sure.
>>>
>>> In fact, one particular machine did not restart openvpn service and so
>>> that one machine did not start using the upgraded version.  It also had
>>> zero data in journalctl for the unit.
>>>
>>> This caused me to check all the other clients ..
>>>
>>> In order to do so I had to change from --verb 0 to --verb > 0 to get the
>>> version line in the log file and then change --verb back to zero again.
>>> And had to restart the instances to get the version in the log
>>> and again had to restart the instances to reset back to --verb 0.
>>>
>>> My suggestion then is:  Always write the *version* of openvpn etc in
>>> use to the log (or logging service) no matter what --verb level is in
>>> use.
>>>
>>> It seems to me like a sensible suggestion .. ?
>>>
>>> Thanks
>>
>> I realise I could set and leave --verb 1 but, if left unattended for any
>> prolonged period of time, even at --verb 1 a log file will continue to
>> grow and on a system where disks space is a serious problem this could
>> eventually fill the disk.
>>
>> Where as --verb 0 will only write the version once and then any fatal 
>> errors.  Which means that, provided there are no fatal errors, the log
>> will remain at only a few bytes indefinitely.
>>
>> thanks
>>
> 
> Or perhaps --verb 1 could be set as Version + Fatal errors only
> and current --verb 1 output moved to --verb 2
> 
> thanks

Also, I realise I could have syslog / journal manage the log but still
at --verb 0 the version is not output and that means I have to make the
verb change to the config to properly confirm the running version ..
which is the knub here!

thanks

