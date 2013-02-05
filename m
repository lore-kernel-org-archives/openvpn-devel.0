Message-ID: <5110D808.1000004@...1147...>
Date: Tue, 05 Feb 2013 10:59:36 +0100
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
References: <510E43DE.20008@...1147...> <510E7997.8040909@...1114...>
	<1CED409804E2164C8104F9E623B08B901349CFBA40@...1436...>
In-Reply-To: <1CED409804E2164C8104F9E623B08B901349CFBA40@...1436...>
Content-Type: multipart/alternative;
	boundary="------------090905070109070905080709"
Subject: Re: [Openvpn-devel] option --crl-verify PATH dir
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Adriaan de Jong <dejong@...1435...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------090905070109070905080709
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Adriaan de Jong wrote:
>> -----Original Message-----
>> From: David Sommerseth [mailto:openvpn.list@...1114...]
>> Sent: zondag 3 februari 2013 15:52
>> To: Jan Just Keijser
>> Cc: openvpn-devel@lists.sourceforge.net
>> Subject: Re: [Openvpn-devel] option --crl-verify PATH dir
>>
>> On 03/02/13 12:02, Jan Just Keijser wrote:
>>     
>>> hi,
>>>
>>> what is the second option to '--crl-verify' supposed to do? in
>>> options.c it sets a flag SSLF_CRL_VERIFY_DIR which then triggers the
>>> function 'verify_check_crl_dir'. However, this function does not seem
>>> to do anything....
>>>       
>> Quickly looked at the code ... with the 'dir' flag (which sets
>> SSLF_CRL_VERIFY_DIR), it's no longer a typical CRL file validation.  If
>> you create (touch) a file in the defined directory with the file name
>> matching a particular client's serial number; the connection will be
>> denied.
>>
>>     
>
> Confirmed, with the footnote that this is a weird way of going about things. 
>
> I would like to suggest deprecating this option from 2.4 (or 2.3.1?) onwards, and forcing people to either:
>
>  - Create an actual CRL file. This is not difficult. In general, people using OpenVPN should be managing their own CA in the OpenVPN world.
>  - Failing that, create a custom script to do this.
>
> I'm always open for discussion, but imho this should not be core functionality in OpenVPN.
>   

I agree that CA cert and CRL management should not be part of the "core" 
functionality of OpenVPN.
In one of my setups I've got a --ca-path containing 108 different CA 
certs, with 108 CRLs for each of them - concatenating those 108 CRLs 
into one big CRL.pem file every day would be a major nuisance...
OpenSSL has very nice support (--ca-path) for a directory containing a 
set of CA certs and their corresponding CRLs; AFAIK PolarSSL does not 
have this option - so perhaps there is some usefulness to this option 
after all?


share and enjoy,

JJK


--------------090905070109070905080709
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
Adriaan de Jong wrote:
<blockquote
 cite="mid:1CED409804E2164C8104F9E623B08B901349CFBA40@...1436..."
 type="cite">
  <blockquote type="cite">
    <pre wrap="">-----Original Message-----
From: David Sommerseth [<a class="moz-txt-link-freetext" href="mailto:openvpn.list@...1114...">mailto:openvpn.list@...1114...</a>]
Sent: zondag 3 februari 2013 15:52
To: Jan Just Keijser
Cc: <a class="moz-txt-link-abbreviated" href="mailto:openvpn-devel@lists.sourceforge.net">openvpn-devel@lists.sourceforge.net</a>
Subject: Re: [Openvpn-devel] option --crl-verify PATH dir

On 03/02/13 12:02, Jan Just Keijser wrote:
    </pre>
    <blockquote type="cite">
      <pre wrap="">hi,

what is the second option to '--crl-verify' supposed to do? in
options.c it sets a flag SSLF_CRL_VERIFY_DIR which then triggers the
function 'verify_check_crl_dir'. However, this function does not seem
to do anything....
      </pre>
    </blockquote>
    <pre wrap="">Quickly looked at the code ... with the 'dir' flag (which sets
SSLF_CRL_VERIFY_DIR), it's no longer a typical CRL file validation.  If
you create (touch) a file in the defined directory with the file name
matching a particular client's serial number; the connection will be
denied.

    </pre>
  </blockquote>
  <pre wrap=""><!---->
Confirmed, with the footnote that this is a weird way of going about things. 

I would like to suggest deprecating this option from 2.4 (or 2.3.1?) onwards, and forcing people to either:

 - Create an actual CRL file. This is not difficult. In general, people using OpenVPN should be managing their own CA in the OpenVPN world.
 - Failing that, create a custom script to do this.

I'm always open for discussion, but imho this should not be core functionality in OpenVPN.
  </pre>
</blockquote>
<br>
I agree that CA cert and CRL management should not be part of the
"core" functionality of OpenVPN.<br>
In one of my setups I've got a --ca-path containing 108 different CA
certs, with 108 CRLs for each of them - concatenating those 108 CRLs
into one big CRL.pem file every day would be a major nuisance...<br>
OpenSSL has very nice support (--ca-path) for a directory containing a
set of CA certs and their corresponding CRLs; AFAIK PolarSSL does not
have this option - so perhaps there is some usefulness to this option
after all? <br>
<br>
<br>
share and enjoy,<br>
<br>
JJK<br>
<br>
</body>
</html>

--------------090905070109070905080709--

