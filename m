Reply-To: openvpn-devel@lists.sourceforge.net
References: <20171010231130.6832-1-simon@...2293...>
 <20171010231130.6832-9-simon@...2293...> <20171105192019.GM958@...1296...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <ca7539ef-da83-1023-dfc7-46d83c7e312a@...2080...>
Date: Sun, 5 Nov 2017 22:16:10 +0100
MIME-Version: 1.0
In-Reply-To: <20171105192019.GM958@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="rNXsPPT602n2AKfXdtLwMvD9maN64CK57"
Subject: Re: [Openvpn-devel] [PATCH 09/13] Signed/unsigned warnings of MSVC
 resolved
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>, simon@...2293...
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rNXsPPT602n2AKfXdtLwMvD9maN64CK57
Content-Type: multipart/mixed; boundary="tn5lhN4b1NuU8N9Ldu8kPU3SpxgV8IH0v";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Gert Doering <gert@...1296...>, simon@...2293...
Cc: openvpn-devel@lists.sourceforge.net
Message-ID: <ca7539ef-da83-1023-dfc7-46d83c7e312a@...2080...>
Subject: Re: [Openvpn-devel] [PATCH 09/13] Signed/unsigned warnings of MSVC
 resolved
References: <20171010231130.6832-1-simon@...2293...>
 <20171010231130.6832-9-simon@...2293...> <20171105192019.GM958@...1296...>
In-Reply-To: <20171105192019.GM958@...1296...>

--tn5lhN4b1NuU8N9Ldu8kPU3SpxgV8IH0v
Content-Language: en-GB
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 05/11/17 20:20, Gert Doering wrote:
>> -modext(LPTSTR dest, int size, LPCTSTR src, LPCTSTR newext)
>> +modext(LPTSTR dest, size_t size, LPCTSTR src, LPCTSTR newext)
>>  {
>>      int i;
> Not sure why this is needed?  The code verifies that size is ">0", so
> a signed variable is ok here.

I would label this more as "use size_t for size/length related
variables".  So I read this more as a coding style change than anything
else.
--tn5lhN4b1NuU8N9Ldu8kPU3SpxgV8IH0v--

--rNXsPPT602n2AKfXdtLwMvD9maN64CK57--
