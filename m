References: <20161216155755.29931-1-list@...1798...>
	<0f4adf76-7aa8-99e1-8fa4-e11f4e574909@...2080...>
From: debbie10t <debbie10t@...277...>
Message-ID: <4a682272-f9a5-5c49-49ff-daf688ec804b@...277...>
Date: Fri, 16 Dec 2016 22:33:54 +0000
MIME-Version: 1.0
In-Reply-To: <0f4adf76-7aa8-99e1-8fa4-e11f4e574909@...2080...>
Subject: Re: [Openvpn-devel] [PATCH 1/1] do not race on RuntimeDirectory
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



On 16/12/16 18:14, David Sommerseth wrote:
> On 16/12/16 16:57, Christian Hesse wrote:
>> From: Christian Hesse <mail@...1798...>
>>
>> Different unit instances create and destroy the same RuntimeDirectory.
>> This leads to running instances where the status file (and possibly
>> more runtime data) is no longer accessible.
>>
>> So create a RuntimeDirectory per instance.
>>
>> Signed-off-by: Christian Hesse <mail@...1798...>
>> ---
>>  distro/systemd/openvpn-client@...1685... | 2 +-
>>  distro/systemd/openvpn-server@...1685... | 4 ++--
>>  2 files changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/distro/systemd/openvpn-client@...1685... b/distro/systemd/openvpn-client@...1685...
>> index 5618af3..fcb5302 100644
>> --- a/distro/systemd/openvpn-client@...1685...
>> +++ b/distro/systemd/openvpn-client@...1685...
>> @@ -9,7 +9,7 @@ Documentation=https://community.openvpn.net/openvpn/wiki/HOWTO
>>  [Service]
>>  Type=notify
>>  PrivateTmp=true
>> -RuntimeDirectory=openvpn-client
>> +RuntimeDirectory=openvpn-client@%i
>
> I am quite sure we tested this, without any luck.  We ended up with a
> directory named openvpn-client@%i ... well, we used openvpn-client-%i,
> but the principle should be the same.
>
> This *might* have been fixed in a newer systemd releases, but as we have
> RHEL7 as the oldest release we need to ensure this works properly there too.
>
> For the server side, we used status-%i.log to avoid clashing on the
> status log.
>
> debbie10t did plenty of testing with various configurations, so he can
> probably fill out more details in the various test cases he used.  We
> should probably document those tests in our wiki though.

This was spotted but I did not take sufficient ownership ..

I will happily test @Christian 's final patch.

regards

