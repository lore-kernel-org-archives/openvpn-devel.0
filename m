References: <20210317181153.83716-1-juliusz@...2525...>
 <202103181321.12IDL2VF012379@...2054...>
 <20210318135631.GB976@...1296...>
From: Juliusz Sosinowicz <juliusz@...2525...>
Message-ID: <afecb5ce-3cda-2791-341b-69dff985118e@...2525...>
Date: Thu, 18 Mar 2021 15:01:16 +0100
MIME-Version: 1.0
In-Reply-To: <20210318135631.GB976@...1296...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Support for wolfSSL in
 OpenVPN
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

which version of autoconf exactly is causing this explosion?

Juliusz

On 18/03/2021 14:56, Gert Doering wrote:
> Hi,
>
> On Thu, Mar 18, 2021 at 02:21:02PM +0100, Gert Doering wrote:
>> Your patch has been applied to the master branch.
>>
>> I have not tested actual WolfSSL builds, but done a quick compile test
>> to see if it would break old/new openssl or old/new mbedtls configure
>> runs.  All works :-)
> Well.  That was too fast.
>
> I did not test with older autoconf versions, and it turns out that
> PKG_CHECK_VAR() is not supported on older versions - this got introduced
> by the WolfSSL patch, and half our buildbots have exploded (Ubuntu 16,
> Ubuntu 18, NetBSD 8.1).
>
> So, we need a fix for that... possibly some addition to our m4/ directory,
> or a rewrite of this configure.ac hunk.
>
> And we want it quick, because our buildbot infrastructure is half-down
> now...
>
> gert
>

