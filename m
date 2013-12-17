Message-ID: <52B01795.20400@...1227...>
Date: Tue, 17 Dec 2013 10:21:25 +0100
From: Arne Schwabe <arne@...1227...>
MIME-Version: 1.0
References: <1387221007-17736-1-git-send-email-arne@...1227...>
	<20131216205912.GP161@...1296...>
In-Reply-To: <20131216205912.GP161@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="3Gi6eesEMAko7ImFee12GR0G06Kv0LKnE"
Subject: Re: [Openvpn-devel] [PATCH] Add warning for using connection block
 variables after connection blocks
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3Gi6eesEMAko7ImFee12GR0G06Kv0LKnE
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Am 16.12.13 21:59, schrieb Gert Doering:
> Hi,
>
> On Mon, Dec 16, 2013 at 08:10:07PM +0100, Arne Schwabe wrote:
>> In 2.3  some options that were allowed only in global config before have=
 been moved to connection blocks. This changes the behaviour if the variabl=
es were defined after connection block. This patch adds a warning to catch =
these mistakes.
>> ---
> Basically, I'm OK with that, just a few things...
>
>> diff --git a/src/openvpn/common.h b/src/openvpn/common.h
>> index 2f85bec..4f32ef1 100644
>> --- a/src/openvpn/common.h
>> +++ b/src/openvpn/common.h
>> @@ -98,6 +98,11 @@ typedef unsigned long ptr_type;
>>  #define INLINE_FILE_TAG "[[INLINE]]"
>>=20=20
>>  /*
>> + * Pseudo filename for connection blocks=20
>> + */
>> +#define CONNECTION_FILE_TAG "[CONNECTION-OPTIONS]"
>> +
> ... as this is only referenced once, is it really worth adding a #define
> which is about as long as the string it's replacing?
>
Yeah. I thought it would be nice for consistency with the other special
file name

>>  	    const int line_num,
>>  	    int msglevel,
>>  	    struct gc_arena *gc)
>> @@ -3805,7 +3805,7 @@ read_config_string (const char *prefix,
>>  	{
>>  	  bypass_doubledash (&p[0]);
>>  	  check_inline_file_via_buf (&multiline, p, &options->gc);
>> -	  add_option (options, p, NULL, line_num, 0, msglevel, permission_mask=
, option_types_found, es);
>> +	  add_option (options, p, prefix, line_num, 0, msglevel, permission_ma=
sk, option_types_found, es);
>>  	}
> Is that "NULL" a generic oversight?  It doesn't seem like it's needed
> for the new functionality, more like "it should have been like that",=20
> right?   (Ah, I can see it now, we want it to not print "[CMD-LINE]"=20
> for these cases, right?)
Yeah. We print CMD-LINE there which is more confusing then helping. And
this function is only called by connection blocks and configs returned
by plugins. So it should be save to fix it.
>
>>        CLEAR (p);
>>      }
>> @@ -3925,27 +3925,43 @@ void options_string_import (struct options *opti=
ons,
>>=20=20
>>  #if P2MP
>>=20=20
>> -#define VERIFY_PERMISSION(mask) { if (!verify_permission(p[0], file, (m=
ask), permission_mask, option_types_found, msglevel)) goto err; }
>> +#define VERIFY_PERMISSION(mask) { if (!verify_permission(p[0], file, li=
ne, (mask), permission_mask, option_types_found, msglevel, options)) goto e=
rr; }
>>=20=20
>>  static bool
>>  verify_permission (const char *name,
>>  		   const char* file,
>> +		   int line,
>>  		   const unsigned int type,
>>  		   const unsigned int allowed,
>>  		   unsigned int *found,
>> -		   const int msglevel)
>> +		   const int msglevel,
>> +		   struct options* options)
>>  {
>>    if (!(type & allowed))
>>      {
>>        msg (msglevel, "option '%s' cannot be used in this context (%s)",=
 name, file);
>>        return false;
>>      }
>> -  else
>> +
>> +  if (found)
>> +    *found |=3D type;
>> +
>> +#ifndef ENABLE_SMALL
>> +  /* Check if this options is allowed in connection block,
>> +   * but we are currently not in a connection block
>> +   * Parsing a connection block uses a temporary options struct without
>> +   * connection_list
>> +   */
>> +
>> +  if ((type & OPT_P_CONNECTION) && options->connection_list)
>>      {
>> -      if (found)
>> -	*found |=3D type;
>> -      return true;
>> +      if (file)
>> +	msg (M_WARN, "Option '%s' in %s:%d is ignored by previous <connection>=
 blocks ", name, file, line);
>> +      else
>> +	msg (M_WARN, "Option '%s' is ignored by previous <connection> blocks",=
 name);
>>      }
>> +#endif
>> +  return true;
>>  }
> OK :-)
>
> (This is actually not changing the "if (*found)..." logic, it just looks
> that way due to the way git diff sometimes produces patches where=20
> whitespace changes close to code additions...)
:-)

Arne



--3Gi6eesEMAko7ImFee12GR0G06Kv0LKnE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (Darwin)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlKwF5sACgkQe8+cMNS4zRf6zACg4aEd3xmEJKPgKWKekF/EP9E0
4o8AmwdJFso4x1yj5AF6a3rLROCUXPqg
=8weO
-----END PGP SIGNATURE-----

--3Gi6eesEMAko7ImFee12GR0G06Kv0LKnE--

