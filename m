Message-ID: <4D9DB4E4.50207@...1147...>
Date: Thu, 07 Apr 2011 14:58:12 +0200
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
References: <1302106222-10256-1-git-send-email-davids@...1347...>	<BANLkTik3QGpmced2mqhxDv6cmNJDZcxFMw@...278...>
	<4D9DB36B.3010202@...1114...>
In-Reply-To: <4D9DB36B.3010202@...1114...>
Subject: Re: [Openvpn-devel] [PATCH] Change the default --tmp-dir path to a
 more suitable path
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: David Sommerseth <openvpn.list@...1114...>
Cc: openvpn-devel@lists.sourceforge.net

David Sommerseth wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> [resend copy to openvpn-devel list as well]
>
> On 07/04/11 14:15, Alon Bar-Lev wrote:
>   
>> On Wed, Apr 6, 2011 at 7:10 PM, David Sommerseth <davids@...1347...> wrote:
>>     
>>> In commit 4e1cc5f6dda22e9 the create_temp_filename() function was
>>> reviewed and hardened, which in the end renamed this function to
>>> create_temp_file() in commit 495e3cec5d156.
>>>
>>> With these changes it became more evident that OpenVPN needs a directory
>>> where it can create temporary files.  The create_temp_file() will create
>>> such files f.ex. if --client-connect or --plugin which makes use of
>>> the OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY hook, such as openvpn-auth-pam.so.
>>>
>>> When this happens, OpenVPN will normally create these files in the directory
>>> OpenVPN was started.  In many cases, this will fail due to restricted access.
>>> By using --tmp-dir and pointing it to a directory writeable to the user
>>> running OpenVPN, it works again.
>>>
>>> This patch makes OpenVPN use a more suitable temproary directory by default,
>>> instead of the current working directory.  On non-Windows platforms this
>>> default value is set to '/tmp', but can be modified at compile-time by
>>> running ./configure --with-tmp-dir-path=<TEMP DIR PATH>.  On Windows, it
>>> will look up %TEMP% and %TMP% first, and if that doesn't give any clues, it
>>> will fallback to C:\WINDOWS\Temp in the end.
>>>       
>> I don't understand,
>> if you use windows environment variables, then why not do the same on Unix?
>> You have the standard TMPDIR [1] variable, and fallback to /tmp.
>>     
>
> I checked for the $TMPDIR variable on CentOS 5.5, Fedora 14 and Gentoo
> installations.  And $TMPDIR didn't show up at all, hence I thought this was
> not a really useful option.  However, I see from the wikipage that this is
> supposed to be part of SuS.  But it seems not to be respected in Linux at
> least.  But fair point.  I can add a similar logic to non-Windows
> installations as well, again with a hard-coded fallback.
>
>   
>> Also, at Windows you should go into %SystemRoot%\Temp using
>> ExpandEnvironmentVariable() and not hardcode C:\
>>     
>
> Good idea!  I wasn't aware of that one.  I'll fix this.  I will anyway
> choose to fallback to C:\WINDOWS\Temp if %SystemRoot% is not found, even
> though I believe this is most likely not something which should happen.
>
> I'll implement the suggested change for autotools as well and propose an
> additional patch to cover your comments.
>
>   

err , didn't we agree to use %TEMP% on windows? AFAIK this env var is 
always there...

And yes, on my Linux boxen there is no $TMPDIR, but I'd like to be able 
to overrule the temporary directory anyways....
So as far as I am concerned the Linux version of the patch is perfect.

cheers,

JJK


