SET session_replication_role = replica;

--
-- PostgreSQL database dump
--

-- Dumped from database version 15.8
-- Dumped by pg_dump version 15.8

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Data for Name: audit_log_entries; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

INSERT INTO "auth"."audit_log_entries" ("instance_id", "id", "payload", "created_at", "ip_address") VALUES
	('00000000-0000-0000-0000-000000000000', '04a29077-b9c0-470e-b2eb-5fcb04ab140a', '{"action":"user_signedup","actor_id":"0e10733c-6660-4c0d-a560-6ff07710765f","actor_name":"Muhammad Hasan Firdaus","actor_username":"hasanfirdaus@protonmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"google"}}', '2025-02-12 12:24:53.164049+00', ''),
	('00000000-0000-0000-0000-000000000000', '19ab82fc-30fe-4858-b5de-4eea8a884847', '{"action":"logout","actor_id":"0e10733c-6660-4c0d-a560-6ff07710765f","actor_name":"Muhammad Hasan Firdaus","actor_username":"hasanfirdaus@protonmail.com","actor_via_sso":false,"log_type":"account"}', '2025-02-12 12:24:53.398705+00', '');


--
-- Data for Name: flow_state; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: users; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

INSERT INTO "auth"."users" ("instance_id", "id", "aud", "role", "email", "encrypted_password", "email_confirmed_at", "invited_at", "confirmation_token", "confirmation_sent_at", "recovery_token", "recovery_sent_at", "email_change_token_new", "email_change", "email_change_sent_at", "last_sign_in_at", "raw_app_meta_data", "raw_user_meta_data", "is_super_admin", "created_at", "updated_at", "phone", "phone_confirmed_at", "phone_change", "phone_change_token", "phone_change_sent_at", "email_change_token_current", "email_change_confirm_status", "banned_until", "reauthentication_token", "reauthentication_sent_at", "is_sso_user", "deleted_at", "is_anonymous") VALUES
	('00000000-0000-0000-0000-000000000000', '0e10733c-6660-4c0d-a560-6ff07710765f', 'authenticated', 'authenticated', 'hasanfirdaus@protonmail.com', NULL, '2025-02-12 12:24:53.164463+00', NULL, '', NULL, '', NULL, '', '', NULL, '2025-02-12 12:24:53.165444+00', '{"provider": "google", "providers": ["google"]}', '{"iss": "https://accounts.google.com", "sub": "109725246011187559209", "name": "Muhammad Hasan Firdaus", "email": "hasanfirdaus@protonmail.com", "picture": "https://lh3.googleusercontent.com/a/ACg8ocIkSEcDFjdsXKRk4pLTytMMxTp4esFugt0ucqjjLKYYrBlgeU4=s96-c", "full_name": "Muhammad Hasan Firdaus", "avatar_url": "https://lh3.googleusercontent.com/a/ACg8ocIkSEcDFjdsXKRk4pLTytMMxTp4esFugt0ucqjjLKYYrBlgeU4=s96-c", "provider_id": "109725246011187559209", "email_verified": true, "phone_verified": false}', NULL, '2025-02-12 12:24:53.159086+00', '2025-02-12 12:24:53.167152+00', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false);


--
-- Data for Name: identities; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

INSERT INTO "auth"."identities" ("provider_id", "user_id", "identity_data", "provider", "last_sign_in_at", "created_at", "updated_at", "id") VALUES
	('109725246011187559209', '0e10733c-6660-4c0d-a560-6ff07710765f', '{"iss": "https://accounts.google.com", "sub": "109725246011187559209", "name": "Muhammad Hasan Firdaus", "email": "hasanfirdaus@protonmail.com", "picture": "https://lh3.googleusercontent.com/a/ACg8ocIkSEcDFjdsXKRk4pLTytMMxTp4esFugt0ucqjjLKYYrBlgeU4=s96-c", "full_name": "Muhammad Hasan Firdaus", "avatar_url": "https://lh3.googleusercontent.com/a/ACg8ocIkSEcDFjdsXKRk4pLTytMMxTp4esFugt0ucqjjLKYYrBlgeU4=s96-c", "provider_id": "109725246011187559209", "email_verified": true, "phone_verified": false}', 'google', '2025-02-12 12:24:53.162151+00', '2025-02-12 12:24:53.162188+00', '2025-02-12 12:24:53.162188+00', 'e2eb6311-8868-405c-b968-4f13ba8e883b');


--
-- Data for Name: instances; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: sessions; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: mfa_amr_claims; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: mfa_factors; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: mfa_challenges; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: one_time_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: refresh_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: sso_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: saml_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: saml_relay_states; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: sso_domains; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: key; Type: TABLE DATA; Schema: pgsodium; Owner: supabase_admin
--



--
-- Data for Name: major; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: study_program; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: class; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: student; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: subject; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: enrollment; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: lecturer; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: room; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: semester; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: schedule; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: subject_task; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: subject_task_student; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: user_roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."user_roles" ("id", "user_id", "role") VALUES
	('23033075-8131-43d5-9a42-7c60269dc750', '0e10733c-6660-4c0d-a560-6ff07710765f', 'admin'),
	('2b837eab-565d-40e9-aa3b-5442d596432a', '0e10733c-6660-4c0d-a560-6ff07710765f', 'student');


--
-- Data for Name: buckets; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--



--
-- Data for Name: objects; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--



--
-- Data for Name: hooks; Type: TABLE DATA; Schema: supabase_functions; Owner: supabase_functions_admin
--



--
-- Data for Name: secrets; Type: TABLE DATA; Schema: vault; Owner: supabase_admin
--



--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE SET; Schema: auth; Owner: supabase_auth_admin
--

SELECT pg_catalog.setval('"auth"."refresh_tokens_id_seq"', 1, true);


--
-- Name: key_key_id_seq; Type: SEQUENCE SET; Schema: pgsodium; Owner: supabase_admin
--

SELECT pg_catalog.setval('"pgsodium"."key_key_id_seq"', 1, false);


--
-- Name: hooks_id_seq; Type: SEQUENCE SET; Schema: supabase_functions; Owner: supabase_functions_admin
--

SELECT pg_catalog.setval('"supabase_functions"."hooks_id_seq"', 1, false);


--
-- PostgreSQL database dump complete
--

RESET ALL;
