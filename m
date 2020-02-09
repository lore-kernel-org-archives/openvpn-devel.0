References: <20200207174818.21050-1-juliusz@...2525...>
 <20200208084558.GV1431@...1296...>
From: Juliusz Sosinowicz <juliusz@...2525...>
Message-ID: <23330b19-35b6-7e4e-2f2e-9c3c1626f53d@...2525...>
Date: Sun, 9 Feb 2020 10:18:34 +0100
MIME-Version: 1.0
In-Reply-To: <20200208084558.GV1431@...1296...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH] Support for wolfSSL with OpenVPN master
 branch
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

Hi Gert,

thank you for your comments. My intention was not to add a second cipher 
line in the sample config file. I added "cipher AES-256-CBC" to an 
earlier version of OpenVPN when there was no cipher specified in the 
loopback-client and loopback-server files. After rebasing my commit onto 
master I didn't notice the double cipher lines in the config files. I 
will remove this in my next patch as wolfSSL does support GCM mode but 
not yet in the compatibility layer.

I will add GCM support to our compatibility layer and send an updated 
signed-off patch with a better commit message explaining what is 
happening in the patch.

Thanks
Juliusz

On 08/02/2020 09:45, Gert Doering wrote:
> Hi Juliusz,
>
> please send patches out of a git tree, coming from a git commit with
> "git commit -s", and having a somewhat relevant commit message.
>
> Besides this, please do not
>
>> --- a/sample/sample-config-files/loopback-client
>> +++ b/sample/sample-config-files/loopback-client
>> @@ -25,3 +25,4 @@ tls-auth sample-keys/ta.key 1
>>   cipher AES-256-GCM
>>   ping 1
>>   inactive 120 10000000
>> +cipher AES-256-CBC
> ... modify the sample config files (and *if* you do, do not just add
> a second cipher line, which will confuse users quite a bit).
>
> If WolfSSL does not support GCM, this needs to be documented, but our
> sample config files contain the recommended cipher for the existing
> crypto systems, and this is (and will continue to be for the time)
> GCM - faster, and lower overhead.
>
> gert

