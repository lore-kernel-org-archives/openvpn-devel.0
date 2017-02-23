Sender: Emmanuel Deloget <emmanueldeloget53@...277...>
From: Emmanuel Deloget <logout@...260...>
Date: Thu, 23 Feb 2017 15:35:55 +0100
Message-Id: <cover.1487859361.git.logout@...260...>
In-Reply-To: <20170220160816.114598d9@...1799...>
References: <20170220160816.114598d9@...1799...>
Subject: [Openvpn-devel] [PATCH v3 00/15] Add support for OpenSSL 1.1.x
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

This is v3 of the remaining patches for the "Add support for OpenSSL 
1.1.x" series. This series is partial: only the modified patches are 
sent to the ML -- the other have not changed. The stats are a bit off 
so I don't include them in this mail.

They have been generated after a rebase from the master tree. Individual
commits can be viewed at

  https://github.com/emmanuel-deloget/openvpn/commits/openssl-1.1-v3

(This time, the branch name is correct :))

Changes v2 --> v3: 

* RSA_METHOD (04/15): rsa_meth->name is now a dup of the name parameter; 
  it's freed in RSA_meth_free(). 

* RSA (07/15): calling RSA_set_method() in rsa_finish() is both a Bad 
  Idea and not required so it has been removed.
  
Changes v1 --> v2:

* EVP_PKEY (06/15): add missing function EVP_PKEY_id() for 0.9.8.

* replace patch 15/15 with a new patch to use EVP_CipherInit_ex() 
  instead of EVP_CipherInit() when a full init is not needed.


Emmanuel Deloget (15):
  [commited] OpenSSL: don't use direct access to the internal of SSL_CTX
  [commited] OpenSSL: don't use direct access to the internal of X509_STORE
  [commited] OpenSSL: don't use direct access to the internal of X509_OBJECT
  OpenSSL: don't use direct access to the internal of RSA_METHOD
  OpenSSL: don't use direct access to the internal of X509
  OpenSSL: don't use direct access to the internal of EVP_PKEY
  OpenSSL: don't use direct access to the internal of RSA
  OpenSSL: don't use direct access to the internal of DSA
  [commited] OpenSSL: don't use direct access to the internal of X509_STORE_CTX
  OpenSSL: don't use direct access to the internal of EVP_MD_CTX
  OpenSSL: don't use direct access to the internal of EVP_CIPHER_CTX
  OpenSSL: don't use direct access to the internal of HMAC_CTX
  OpenSSL: SSLeay symbols are no longer available in OpenSSL 1.1
  OpenSSL: constify getbio() parameters
  OpenSSL: use EVP_CipherInit_ex() instead of EVP_CipherInit()

-- 
2.7.4


