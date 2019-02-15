References: <20190122150333.1061-1-arne@...1227...>
 <20190122150333.1061-2-arne@...1227...>
 <38ffdb09-276d-8f5a-ce81-f3d36a1e685b@...2080...>
 <b2fabdd9-8310-eba3-4f71-0d60430c3ed1@...515...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <9a05596c-a77a-3a39-6486-9cb2edd05457@...2080...>
Date: Fri, 15 Feb 2019 21:40:18 +0100
MIME-Version: 1.0
In-Reply-To: <b2fabdd9-8310-eba3-4f71-0d60430c3ed1@...515...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH v2 2/6] Allow pem_read_key_file to
 generate a random key
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: Arne Schwabe <arne@...515...>, Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

On 08/02/2019 15:50, Arne Schwabe wrote:
> Am 08.02.19 um 13:30 schrieb David Sommerseth:
>> On 22/01/2019 16:03, Arne Schwabe wrote:
>>> From: Arne Schwabe <arne@...515...>
>>>
>>> This is useful for features that can use either a persistent
>>> or an ephemeral key.
>> Agreed, this is valuable.  But I generally don't like "hiding" this feature
>> behind an argument to {read,write}_pem_key_file().  I prefer having functions
>> doing explicit things, not "I can do this, or this, or this" depending on the
>> arguments given.
>>
>> Rather add a generate_random_pem_key() which does just that.
>>
> That name would completely confusing that is not what it does. It is
> more really load a key from a file or generate one on the fly.
> 
> Should add a small wrapper function that is something
> load_key_or_random? I also don't really want to rename the function
> read_pem_key_file as that is the main function of it. Return the
> ephermal key is just for function that can work with that.

What I find confusing is:


     if (!read_pem_key_file(&client_key, tls_crypt_v2_cli_pem_name,
                            key_file, key_inline, false))

Flip that 'false' to 'true' and you get a different behaviour if key_file == NULL.

In this case I would prefer to have the "which key will I use" logic in
auth_token_init_secret().  In the following patch 3/6, you have this:

     if (!read_pem_key_file(&server_secret_key, auth_token_pem_name,
                            key_file, key_inline, true))

I would prefer:

    if (NULL == key_file)
    {
        generate_key_file(...);
	....
    }
    else if (!read_pem_key_file(&server_secret_key, auth_token_pem_name,
                            key_file, key_inline))
    {
       ....
    }

This is much more explicit in the behaviour when reading the code, you don't
need to parse through the arguments of read_pem_key_file() to understand how
it behaves.

This will also not requiring touching tls_crypt_v2_init_client_key() or
read_pem_key_file() at all.  So this change would even be less intrusive.


>>> -    if (strcmp(key_file, INLINE_FILE_TAG))
>>> +    if (key_file && strcmp(key_file, INLINE_FILE_TAG))
>> Is this fixing a bug?  I'd recommend putting such fixes in a separate commit.
> 
> No, key_file can now be null since in this case we generate the random
> key material.

Fine, then it makes sense where it is :)


-- 
kind regards,

David Sommerseth
OpenVPN Inc


