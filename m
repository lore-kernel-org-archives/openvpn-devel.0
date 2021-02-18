References: <8d6cbe40-bbc0-ddd4-ed5b-1acb9b6967fb@...277...>
 <CAKuzo_hxUNby2-PSV+eJwDs0gvaePzs9tjTx9LGEXxwM2ye1nA@...278...>
From: tincanteksup <tincanteksup@...277...>
Message-ID: <8cb2eacf-95dc-d036-f2b3-b3eef2c2ddad@...277...>
Date: Thu, 18 Feb 2021 21:36:41 +0000
MIME-Version: 1.0
In-Reply-To: <CAKuzo_hxUNby2-PSV+eJwDs0gvaePzs9tjTx9LGEXxwM2ye1nA@...278...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [Openvpn-devel/users] Debugging Windows based
 server scripts
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Selva Nair <selva.nair@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>, "openvpn-users@lists.sourceforge.net" <openvpn-users@lists.sourceforge.net>



On 18/02/2021 19:13, Selva Nair wrote:
> Hi,
> 
> On Wed, Feb 17, 2021 at 5:38 PM tincanteksup <tincanteksup@...277...> wrote:
> 
>> Hi,
>>
>> due to not being allowed to have scripts "echo data" to the log file
>> under Windows, debugging scripts is next to impossible.
>>
>> I presume there are no compile time options to enable "echo" under Windows
>> ?
>>
>> Could anybody provide me with a patch to enable "echo" just for the
>> purpose of debugging ?
>>
>> I would like the patch to work for Openvpn 2.5
>>
>> I understand the risks and I am not distributing OpenVPN binaries.
>>
>> As justification I make these points:
>>
>> * Any large distributor of Openvpn binaries could make the change to
>> enable "echo" under Windows.
>>
>> * That distributor could then abuse it as they please.
>>
>> * I am simply asking for help for the purpose of debugging Open Source
>> Software made for the community.
> 
> 
> If it's for debugging, why not redirect the output of the scripts? There
> are several ways of doing this like:
> 
> (i) replace the script by a wrapper
> 
> @echo off
> rem this wrapper calls the actual up_script_orig.bat
> call up_script_orig.bat >up_script.log 2>&1
> exit /b
> 
> (ii) move the script to a function and call it, redirecting o/p
> 
> @echo off
> call :do_work >up_script.log 2>&1
> exit /b
> 
> :do_work
> @echo on
> @rem the original script follows..
> ....
> ....
> @rem end of script
> @echo off
> exit /b
> 
> Selva
> 


Hi Selva, thanks for the suggestions and, as it turns out, reminders! It 
has been quite some time since I picked a fight with Windows batch. I 
have now, at last, got past the first hurdle ..this "blackbox" is 
starting to look a little less opaque ;-)

R


