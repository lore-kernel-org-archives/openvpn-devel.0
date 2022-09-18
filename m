Message-ID: <8182b813-1b12-7548-0c5d-796547b806ea@...1227...>
Date: Sun, 18 Sep 2022 22:39:02 +0200
MIME-Version: 1.0
References: <20220520213250.3126372-1-arne@...1227...>
 <20220914170134.2659433-1-arne@...1227...> <YydGffOjq1jROPN2@...1296...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <YydGffOjq1jROPN2@...1296...>
Subject: Re: [Openvpn-devel] [PATCH v4] Implement AUTH_FAIL,
 TEMP message support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net


Am 18.09.2022 um 18:25 schrieb Gert Doering:
> Hi,
>
> On Wed, Sep 14, 2022 at 07:01:34PM +0200, Arne Schwabe wrote:
>>   src/openvpn/openvpn.vcxproj          |   2 +
> This file is still gone, so the hunk also needs to go.  But I can
> ignore this.
>
>> diff --git a/doc/man-sections/script-options.rst b/doc/man-sections/script-options.rst
>> index 61c89b0ad..2a2e70fca 100644
>> --- a/doc/man-sections/script-options.rst
>> +++ b/doc/man-sections/script-options.rst
>> @@ -102,6 +102,42 @@ SCRIPT HOOKS
>>     the authentication, a :code:`1` or :code:`0` must be written to the
>>     file specified by the :code:`auth_control_file`.
>>   
>> +  If the file specified by :code:`auth_failed_reason` exists and has non-empty
> If this is referring to the environment variable, it needs to be
> "auth_failed_reason_file".  If you agree, I'll change that on merge.

Yes sorry. My mistake.


Arne


