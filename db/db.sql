--
-- PostgreSQL database dump
--

-- Dumped from database version 12.4
-- Dumped by pg_dump version 12.4

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: auth_group; Type: TABLE; Schema: public; Owner: cnc_helper_user
--

CREATE TABLE public.auth_group (
    id integer NOT NULL,
    name character varying(150) NOT NULL
);


ALTER TABLE public.auth_group OWNER TO cnc_helper_user;

--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: cnc_helper_user
--

CREATE SEQUENCE public.auth_group_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_id_seq OWNER TO cnc_helper_user;

--
-- Name: auth_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cnc_helper_user
--

ALTER SEQUENCE public.auth_group_id_seq OWNED BY public.auth_group.id;


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: cnc_helper_user
--

CREATE TABLE public.auth_group_permissions (
    id integer NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_group_permissions OWNER TO cnc_helper_user;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: cnc_helper_user
--

CREATE SEQUENCE public.auth_group_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_permissions_id_seq OWNER TO cnc_helper_user;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cnc_helper_user
--

ALTER SEQUENCE public.auth_group_permissions_id_seq OWNED BY public.auth_group_permissions.id;


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: cnc_helper_user
--

CREATE TABLE public.auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE public.auth_permission OWNER TO cnc_helper_user;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: cnc_helper_user
--

CREATE SEQUENCE public.auth_permission_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_permission_id_seq OWNER TO cnc_helper_user;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cnc_helper_user
--

ALTER SEQUENCE public.auth_permission_id_seq OWNED BY public.auth_permission.id;


--
-- Name: authtoken_token; Type: TABLE; Schema: public; Owner: cnc_helper_user
--

CREATE TABLE public.authtoken_token (
    key character varying(40) NOT NULL,
    created timestamp with time zone NOT NULL,
    user_id character varying(30) NOT NULL
);


ALTER TABLE public.authtoken_token OWNER TO cnc_helper_user;

--
-- Name: cnc_activity_machine; Type: TABLE; Schema: public; Owner: cnc_helper_user
--

CREATE TABLE public.cnc_activity_machine (
    inventory_number character varying(60) NOT NULL,
    name character varying(100) NOT NULL
);


ALTER TABLE public.cnc_activity_machine OWNER TO cnc_helper_user;

--
-- Name: cnc_activity_machine_supervisors; Type: TABLE; Schema: public; Owner: cnc_helper_user
--

CREATE TABLE public.cnc_activity_machine_supervisors (
    id integer NOT NULL,
    machine_id character varying(60) NOT NULL,
    user_id character varying(30) NOT NULL
);


ALTER TABLE public.cnc_activity_machine_supervisors OWNER TO cnc_helper_user;

--
-- Name: cnc_activity_machine_supervisors_id_seq; Type: SEQUENCE; Schema: public; Owner: cnc_helper_user
--

CREATE SEQUENCE public.cnc_activity_machine_supervisors_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cnc_activity_machine_supervisors_id_seq OWNER TO cnc_helper_user;

--
-- Name: cnc_activity_machine_supervisors_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cnc_helper_user
--

ALTER SEQUENCE public.cnc_activity_machine_supervisors_id_seq OWNED BY public.cnc_activity_machine_supervisors.id;


--
-- Name: cnc_activity_machine_workers; Type: TABLE; Schema: public; Owner: cnc_helper_user
--

CREATE TABLE public.cnc_activity_machine_workers (
    id integer NOT NULL,
    machine_id character varying(60) NOT NULL,
    user_id character varying(30) NOT NULL
);


ALTER TABLE public.cnc_activity_machine_workers OWNER TO cnc_helper_user;

--
-- Name: cnc_activity_machine_workers_id_seq; Type: SEQUENCE; Schema: public; Owner: cnc_helper_user
--

CREATE SEQUENCE public.cnc_activity_machine_workers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cnc_activity_machine_workers_id_seq OWNER TO cnc_helper_user;

--
-- Name: cnc_activity_machine_workers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cnc_helper_user
--

ALTER SEQUENCE public.cnc_activity_machine_workers_id_seq OWNED BY public.cnc_activity_machine_workers.id;


--
-- Name: cnc_activity_machinelog; Type: TABLE; Schema: public; Owner: cnc_helper_user
--

CREATE TABLE public.cnc_activity_machinelog (
    id integer NOT NULL,
    created timestamp with time zone NOT NULL,
    log_header character varying(150) NOT NULL,
    log_text text NOT NULL,
    bench_id character varying(60) NOT NULL,
    worked_now_id character varying(30) NOT NULL
);


ALTER TABLE public.cnc_activity_machinelog OWNER TO cnc_helper_user;

--
-- Name: cnc_activity_machinelog_id_seq; Type: SEQUENCE; Schema: public; Owner: cnc_helper_user
--

CREATE SEQUENCE public.cnc_activity_machinelog_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cnc_activity_machinelog_id_seq OWNER TO cnc_helper_user;

--
-- Name: cnc_activity_machinelog_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cnc_helper_user
--

ALTER SEQUENCE public.cnc_activity_machinelog_id_seq OWNED BY public.cnc_activity_machinelog.id;


--
-- Name: cnc_activity_machinelog_readers; Type: TABLE; Schema: public; Owner: cnc_helper_user
--

CREATE TABLE public.cnc_activity_machinelog_readers (
    id integer NOT NULL,
    machinelog_id integer NOT NULL,
    user_id character varying(30) NOT NULL
);


ALTER TABLE public.cnc_activity_machinelog_readers OWNER TO cnc_helper_user;

--
-- Name: cnc_activity_machinelog_readers_id_seq; Type: SEQUENCE; Schema: public; Owner: cnc_helper_user
--

CREATE SEQUENCE public.cnc_activity_machinelog_readers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cnc_activity_machinelog_readers_id_seq OWNER TO cnc_helper_user;

--
-- Name: cnc_activity_machinelog_readers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cnc_helper_user
--

ALTER SEQUENCE public.cnc_activity_machinelog_readers_id_seq OWNED BY public.cnc_activity_machinelog_readers.id;


--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: cnc_helper_user
--

CREATE TABLE public.django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id character varying(30) NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);


ALTER TABLE public.django_admin_log OWNER TO cnc_helper_user;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: cnc_helper_user
--

CREATE SEQUENCE public.django_admin_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_admin_log_id_seq OWNER TO cnc_helper_user;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cnc_helper_user
--

ALTER SEQUENCE public.django_admin_log_id_seq OWNED BY public.django_admin_log.id;


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: cnc_helper_user
--

CREATE TABLE public.django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE public.django_content_type OWNER TO cnc_helper_user;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: cnc_helper_user
--

CREATE SEQUENCE public.django_content_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_content_type_id_seq OWNER TO cnc_helper_user;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cnc_helper_user
--

ALTER SEQUENCE public.django_content_type_id_seq OWNED BY public.django_content_type.id;


--
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: cnc_helper_user
--

CREATE TABLE public.django_migrations (
    id integer NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE public.django_migrations OWNER TO cnc_helper_user;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: cnc_helper_user
--

CREATE SEQUENCE public.django_migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_migrations_id_seq OWNER TO cnc_helper_user;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cnc_helper_user
--

ALTER SEQUENCE public.django_migrations_id_seq OWNED BY public.django_migrations.id;


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: cnc_helper_user
--

CREATE TABLE public.django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE public.django_session OWNER TO cnc_helper_user;

--
-- Name: user_profile_emailconfirmation; Type: TABLE; Schema: public; Owner: cnc_helper_user
--

CREATE TABLE public.user_profile_emailconfirmation (
    uuid uuid NOT NULL,
    new_mail character varying(254) NOT NULL,
    send_to character varying(254) NOT NULL,
    is_confirmed boolean NOT NULL,
    user_id character varying(30) NOT NULL,
    created timestamp with time zone NOT NULL
);


ALTER TABLE public.user_profile_emailconfirmation OWNER TO cnc_helper_user;

--
-- Name: user_profile_user; Type: TABLE; Schema: public; Owner: cnc_helper_user
--

CREATE TABLE public.user_profile_user (
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    username character varying(30) NOT NULL,
    email character varying(254) NOT NULL,
    first_name character varying(30) NOT NULL,
    last_name character varying(30) NOT NULL,
    birth_date date,
    date_joined timestamp with time zone NOT NULL,
    is_supervisor boolean NOT NULL,
    is_active boolean NOT NULL,
    is_staff boolean NOT NULL,
    is_verified boolean NOT NULL
);


ALTER TABLE public.user_profile_user OWNER TO cnc_helper_user;

--
-- Name: user_profile_user_groups; Type: TABLE; Schema: public; Owner: cnc_helper_user
--

CREATE TABLE public.user_profile_user_groups (
    id integer NOT NULL,
    user_id character varying(30) NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.user_profile_user_groups OWNER TO cnc_helper_user;

--
-- Name: user_profile_user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: cnc_helper_user
--

CREATE SEQUENCE public.user_profile_user_groups_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_profile_user_groups_id_seq OWNER TO cnc_helper_user;

--
-- Name: user_profile_user_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cnc_helper_user
--

ALTER SEQUENCE public.user_profile_user_groups_id_seq OWNED BY public.user_profile_user_groups.id;


--
-- Name: user_profile_user_user_permissions; Type: TABLE; Schema: public; Owner: cnc_helper_user
--

CREATE TABLE public.user_profile_user_user_permissions (
    id integer NOT NULL,
    user_id character varying(30) NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.user_profile_user_user_permissions OWNER TO cnc_helper_user;

--
-- Name: user_profile_user_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: cnc_helper_user
--

CREATE SEQUENCE public.user_profile_user_user_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_profile_user_user_permissions_id_seq OWNER TO cnc_helper_user;

--
-- Name: user_profile_user_user_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cnc_helper_user
--

ALTER SEQUENCE public.user_profile_user_user_permissions_id_seq OWNED BY public.user_profile_user_user_permissions.id;


--
-- Name: auth_group id; Type: DEFAULT; Schema: public; Owner: cnc_helper_user
--

ALTER TABLE ONLY public.auth_group ALTER COLUMN id SET DEFAULT nextval('public.auth_group_id_seq'::regclass);


--
-- Name: auth_group_permissions id; Type: DEFAULT; Schema: public; Owner: cnc_helper_user
--

ALTER TABLE ONLY public.auth_group_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_group_permissions_id_seq'::regclass);


--
-- Name: auth_permission id; Type: DEFAULT; Schema: public; Owner: cnc_helper_user
--

ALTER TABLE ONLY public.auth_permission ALTER COLUMN id SET DEFAULT nextval('public.auth_permission_id_seq'::regclass);


--
-- Name: cnc_activity_machine_supervisors id; Type: DEFAULT; Schema: public; Owner: cnc_helper_user
--

ALTER TABLE ONLY public.cnc_activity_machine_supervisors ALTER COLUMN id SET DEFAULT nextval('public.cnc_activity_machine_supervisors_id_seq'::regclass);


--
-- Name: cnc_activity_machine_workers id; Type: DEFAULT; Schema: public; Owner: cnc_helper_user
--

ALTER TABLE ONLY public.cnc_activity_machine_workers ALTER COLUMN id SET DEFAULT nextval('public.cnc_activity_machine_workers_id_seq'::regclass);


--
-- Name: cnc_activity_machinelog id; Type: DEFAULT; Schema: public; Owner: cnc_helper_user
--

ALTER TABLE ONLY public.cnc_activity_machinelog ALTER COLUMN id SET DEFAULT nextval('public.cnc_activity_machinelog_id_seq'::regclass);


--
-- Name: cnc_activity_machinelog_readers id; Type: DEFAULT; Schema: public; Owner: cnc_helper_user
--

ALTER TABLE ONLY public.cnc_activity_machinelog_readers ALTER COLUMN id SET DEFAULT nextval('public.cnc_activity_machinelog_readers_id_seq'::regclass);


--
-- Name: django_admin_log id; Type: DEFAULT; Schema: public; Owner: cnc_helper_user
--

ALTER TABLE ONLY public.django_admin_log ALTER COLUMN id SET DEFAULT nextval('public.django_admin_log_id_seq'::regclass);


--
-- Name: django_content_type id; Type: DEFAULT; Schema: public; Owner: cnc_helper_user
--

ALTER TABLE ONLY public.django_content_type ALTER COLUMN id SET DEFAULT nextval('public.django_content_type_id_seq'::regclass);


--
-- Name: django_migrations id; Type: DEFAULT; Schema: public; Owner: cnc_helper_user
--

ALTER TABLE ONLY public.django_migrations ALTER COLUMN id SET DEFAULT nextval('public.django_migrations_id_seq'::regclass);


--
-- Name: user_profile_user_groups id; Type: DEFAULT; Schema: public; Owner: cnc_helper_user
--

ALTER TABLE ONLY public.user_profile_user_groups ALTER COLUMN id SET DEFAULT nextval('public.user_profile_user_groups_id_seq'::regclass);


--
-- Name: user_profile_user_user_permissions id; Type: DEFAULT; Schema: public; Owner: cnc_helper_user
--

ALTER TABLE ONLY public.user_profile_user_user_permissions ALTER COLUMN id SET DEFAULT nextval('public.user_profile_user_user_permissions_id_seq'::regclass);


--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: cnc_helper_user
--

COPY public.auth_group (id, name) FROM stdin;
\.


--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: cnc_helper_user
--

COPY public.auth_group_permissions (id, group_id, permission_id) FROM stdin;
\.


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: cnc_helper_user
--

COPY public.auth_permission (id, name, content_type_id, codename) FROM stdin;
1	Can add log entry	1	add_logentry
2	Can change log entry	1	change_logentry
3	Can delete log entry	1	delete_logentry
4	Can view log entry	1	view_logentry
5	Can add permission	2	add_permission
6	Can change permission	2	change_permission
7	Can delete permission	2	delete_permission
8	Can view permission	2	view_permission
9	Can add group	3	add_group
10	Can change group	3	change_group
11	Can delete group	3	delete_group
12	Can view group	3	view_group
13	Can add content type	4	add_contenttype
14	Can change content type	4	change_contenttype
15	Can delete content type	4	delete_contenttype
16	Can view content type	4	view_contenttype
17	Can add session	5	add_session
18	Can change session	5	change_session
19	Can delete session	5	delete_session
20	Can view session	5	view_session
21	Can add Token	6	add_token
22	Can change Token	6	change_token
23	Can delete Token	6	delete_token
24	Can view Token	6	view_token
25	Can add user	7	add_user
26	Can change user	7	change_user
27	Can delete user	7	delete_user
28	Can view user	7	view_user
29	Can add email confirmation	8	add_emailconfirmation
30	Can change email confirmation	8	change_emailconfirmation
31	Can delete email confirmation	8	delete_emailconfirmation
32	Can view email confirmation	8	view_emailconfirmation
33	Can add machine	9	add_machine
34	Can change machine	9	change_machine
35	Can delete machine	9	delete_machine
36	Can view machine	9	view_machine
37	Can add machine log	10	add_machinelog
38	Can change machine log	10	change_machinelog
39	Can delete machine log	10	delete_machinelog
40	Can view machine log	10	view_machinelog
\.


--
-- Data for Name: authtoken_token; Type: TABLE DATA; Schema: public; Owner: cnc_helper_user
--

COPY public.authtoken_token (key, created, user_id) FROM stdin;
c8d47a98e8c93f9574189af16b83a871b50ff791	2020-08-18 18:35:44.983118+03	admin
a0d21378c9dbc62dbf7a632a22c1eb4095b2a22b	2020-08-26 21:23:06.196279+03	qwerty
\.


--
-- Data for Name: cnc_activity_machine; Type: TABLE DATA; Schema: public; Owner: cnc_helper_user
--

COPY public.cnc_activity_machine (inventory_number, name) FROM stdin;
123456789	Перший тестовий
\.


--
-- Data for Name: cnc_activity_machine_supervisors; Type: TABLE DATA; Schema: public; Owner: cnc_helper_user
--

COPY public.cnc_activity_machine_supervisors (id, machine_id, user_id) FROM stdin;
1	123456789	admin
\.


--
-- Data for Name: cnc_activity_machine_workers; Type: TABLE DATA; Schema: public; Owner: cnc_helper_user
--

COPY public.cnc_activity_machine_workers (id, machine_id, user_id) FROM stdin;
2	123456789	qwerty
\.


--
-- Data for Name: cnc_activity_machinelog; Type: TABLE DATA; Schema: public; Owner: cnc_helper_user
--

COPY public.cnc_activity_machinelog (id, created, log_header, log_text, bench_id, worked_now_id) FROM stdin;
1	2020-08-26 21:31:38.095289+03	Safety error	Safety shield is not installed. You must install it.	123456789	qwerty
2	2020-08-26 21:31:38.208281+03	Safety error	Safety shield is not installed. You must install it.	123456789	qwerty
3	2020-08-26 21:31:38.316279+03	Safety error	Safety shield is not installed. You must install it.	123456789	qwerty
4	2020-08-26 21:31:38.423281+03	Safety error	Safety shield is not installed. You must install it.	123456789	qwerty
5	2020-08-26 21:31:38.535281+03	Safety error	Safety shield is not installed. You must install it.	123456789	qwerty
6	2020-08-26 21:31:38.64328+03	Safety error	Safety shield is not installed. You must install it.	123456789	qwerty
7	2020-08-26 21:31:38.782281+03	Safety error	Safety shield is not installed. You must install it.	123456789	qwerty
8	2020-08-26 21:31:38.906279+03	Safety error	Safety shield is not installed. You must install it.	123456789	qwerty
9	2020-08-26 21:31:39.02328+03	Safety error	Safety shield is not installed. You must install it.	123456789	qwerty
10	2020-08-26 21:31:39.151284+03	Safety error	Safety shield is not installed. You must install it.	123456789	qwerty
11	2020-08-26 21:31:39.260279+03	Safety error	Safety shield is not installed. You must install it.	123456789	qwerty
12	2020-08-26 21:31:39.36828+03	Safety error	Safety shield is not installed. You must install it.	123456789	qwerty
13	2020-08-26 21:31:39.480282+03	Safety error	Safety shield is not installed. You must install it.	123456789	qwerty
14	2020-08-26 21:31:39.594278+03	Safety error	Safety shield is not installed. You must install it.	123456789	qwerty
15	2020-08-26 21:31:39.712281+03	Safety error	Safety shield is not installed. You must install it.	123456789	qwerty
\.


--
-- Data for Name: cnc_activity_machinelog_readers; Type: TABLE DATA; Schema: public; Owner: cnc_helper_user
--

COPY public.cnc_activity_machinelog_readers (id, machinelog_id, user_id) FROM stdin;
1	1	admin
2	2	admin
3	3	admin
4	4	admin
5	5	admin
6	6	admin
7	7	admin
8	8	admin
9	9	admin
10	10	admin
11	11	admin
12	12	admin
13	13	admin
14	14	admin
15	15	admin
\.


--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: cnc_helper_user
--

COPY public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
1	2020-08-26 21:17:57.510287+03	admin	admin	2	[{"changed": {"fields": ["Is supervisor", "Is verified"]}}]	7	admin
2	2020-08-26 21:24:21.57228+03	qwerty	qwerty	2	[{"changed": {"fields": ["Is verified"]}}]	7	admin
\.


--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: cnc_helper_user
--

COPY public.django_content_type (id, app_label, model) FROM stdin;
1	admin	logentry
2	auth	permission
3	auth	group
4	contenttypes	contenttype
5	sessions	session
6	authtoken	token
7	user_profile	user
8	user_profile	emailconfirmation
9	cnc_activity	machine
10	cnc_activity	machinelog
\.


--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: cnc_helper_user
--

COPY public.django_migrations (id, app, name, applied) FROM stdin;
1	contenttypes	0001_initial	2020-08-18 18:30:35.388256+03
2	contenttypes	0002_remove_content_type_name	2020-08-18 18:30:35.418247+03
3	auth	0001_initial	2020-08-18 18:30:35.544245+03
4	auth	0002_alter_permission_name_max_length	2020-08-18 18:30:35.721248+03
5	auth	0003_alter_user_email_max_length	2020-08-18 18:30:35.732245+03
6	auth	0004_alter_user_username_opts	2020-08-18 18:30:35.743244+03
7	auth	0005_alter_user_last_login_null	2020-08-18 18:30:35.755246+03
8	auth	0006_require_contenttypes_0002	2020-08-18 18:30:35.760245+03
9	auth	0007_alter_validators_add_error_messages	2020-08-18 18:30:35.772248+03
10	auth	0008_alter_user_username_max_length	2020-08-18 18:30:35.784247+03
11	auth	0009_alter_user_last_name_max_length	2020-08-18 18:30:35.795248+03
12	auth	0010_alter_group_name_max_length	2020-08-18 18:30:35.815244+03
13	auth	0011_update_proxy_permissions	2020-08-18 18:30:35.829247+03
14	user_profile	0001_initial	2020-08-18 18:30:35.962247+03
15	admin	0001_initial	2020-08-18 18:30:36.277246+03
16	admin	0002_logentry_remove_auto_add	2020-08-18 18:30:36.370247+03
17	admin	0003_logentry_add_action_flag_choices	2020-08-18 18:30:36.386247+03
18	authtoken	0001_initial	2020-08-18 18:30:36.456247+03
19	authtoken	0002_auto_20160226_1747	2020-08-18 18:30:36.599246+03
20	cnc_activity	0001_initial	2020-08-18 18:30:36.848248+03
21	cnc_activity	0002_auto_20200804_1444	2020-08-18 18:30:37.247247+03
22	sessions	0001_initial	2020-08-18 18:30:37.400248+03
23	user_profile	0002_auto_20200723_2343	2020-08-18 18:30:37.544248+03
24	user_profile	0003_auto_20200723_2359	2020-08-18 18:30:37.567245+03
25	user_profile	0004_auto_20200725_1552	2020-08-18 18:30:37.667248+03
26	user_profile	0005_emailconfirmation_created	2020-08-18 18:30:37.734247+03
\.


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: cnc_helper_user
--

COPY public.django_session (session_key, session_data, expire_date) FROM stdin;
armsn9y5yg35naiy0m18r90ui3sm9pni	MWI4MjA4OWIxMWM5YTJmNTVmMzAzOTY0ZTI5MjY2YjAzNzM0ZTA5NTp7Il9hdXRoX3VzZXJfaWQiOiJhZG1pbiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiNTkyNWRlMjUyZTVjYTQ1MGQzNWYzMDg3NmJmN2I2ZTVhY2VmZDRlMyJ9	2020-09-09 21:17:46.113288+03
\.


--
-- Data for Name: user_profile_emailconfirmation; Type: TABLE DATA; Schema: public; Owner: cnc_helper_user
--

COPY public.user_profile_emailconfirmation (uuid, new_mail, send_to, is_confirmed, user_id, created) FROM stdin;
a01e77f9-893a-4524-863a-fc44c90a90ac	django.backend.dev@gmail.com	django.backend.dev@gmail.com	f	admin	2020-08-18 18:35:44.989117+03
27ad11e4-bffd-41f8-ae0d-dd2a50265a8f	abhjdbbj@bjcbsakj.cy	abhjdbbj@bjcbsakj.cy	f	qwerty	2020-08-26 21:23:06.20028+03
\.


--
-- Data for Name: user_profile_user; Type: TABLE DATA; Schema: public; Owner: cnc_helper_user
--

COPY public.user_profile_user (password, last_login, is_superuser, username, email, first_name, last_name, birth_date, date_joined, is_supervisor, is_active, is_staff, is_verified) FROM stdin;
pbkdf2_sha256$180000$oeBm8kgt3UtL$9tMThBdZKZmscwPQV+9NJfd4xtAgkCpciJIv9qqTajk=	2020-08-26 21:17:46+03	t	admin	django.backend.dev@gmail.com	Django	Admin	2004-08-01	2020-08-26 21:17:57.500277+03	t	t	t	t
pbkdf2_sha256$180000$IXra22M83n5p$wR3F5aF/NTxIQ5qC554MB0GHcyo1XqLpbwSDcKYaetw=	\N	f	qwerty	abhjdbbj@bjcbsakj.cy	Fgfsfd	Fsadas	2004-07-31	2020-08-26 21:24:21.562281+03	f	t	f	t
\.


--
-- Data for Name: user_profile_user_groups; Type: TABLE DATA; Schema: public; Owner: cnc_helper_user
--

COPY public.user_profile_user_groups (id, user_id, group_id) FROM stdin;
\.


--
-- Data for Name: user_profile_user_user_permissions; Type: TABLE DATA; Schema: public; Owner: cnc_helper_user
--

COPY public.user_profile_user_user_permissions (id, user_id, permission_id) FROM stdin;
\.


--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cnc_helper_user
--

SELECT pg_catalog.setval('public.auth_group_id_seq', 1, false);


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cnc_helper_user
--

SELECT pg_catalog.setval('public.auth_group_permissions_id_seq', 1, false);


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cnc_helper_user
--

SELECT pg_catalog.setval('public.auth_permission_id_seq', 40, true);


--
-- Name: cnc_activity_machine_supervisors_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cnc_helper_user
--

SELECT pg_catalog.setval('public.cnc_activity_machine_supervisors_id_seq', 1, true);


--
-- Name: cnc_activity_machine_workers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cnc_helper_user
--

SELECT pg_catalog.setval('public.cnc_activity_machine_workers_id_seq', 2, true);


--
-- Name: cnc_activity_machinelog_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cnc_helper_user
--

SELECT pg_catalog.setval('public.cnc_activity_machinelog_id_seq', 15, true);


--
-- Name: cnc_activity_machinelog_readers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cnc_helper_user
--

SELECT pg_catalog.setval('public.cnc_activity_machinelog_readers_id_seq', 15, true);


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cnc_helper_user
--

SELECT pg_catalog.setval('public.django_admin_log_id_seq', 2, true);


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cnc_helper_user
--

SELECT pg_catalog.setval('public.django_content_type_id_seq', 10, true);


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cnc_helper_user
--

SELECT pg_catalog.setval('public.django_migrations_id_seq', 26, true);


--
-- Name: user_profile_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cnc_helper_user
--

SELECT pg_catalog.setval('public.user_profile_user_groups_id_seq', 1, false);


--
-- Name: user_profile_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cnc_helper_user
--

SELECT pg_catalog.setval('public.user_profile_user_user_permissions_id_seq', 1, false);


--
-- Name: auth_group auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: cnc_helper_user
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions auth_group_permissions_group_id_permission_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: public; Owner: cnc_helper_user
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: cnc_helper_user
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: cnc_helper_user
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission auth_permission_content_type_id_codename_01ab375a_uniq; Type: CONSTRAINT; Schema: public; Owner: cnc_helper_user
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- Name: auth_permission auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: cnc_helper_user
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: authtoken_token authtoken_token_pkey; Type: CONSTRAINT; Schema: public; Owner: cnc_helper_user
--

ALTER TABLE ONLY public.authtoken_token
    ADD CONSTRAINT authtoken_token_pkey PRIMARY KEY (key);


--
-- Name: authtoken_token authtoken_token_user_id_key; Type: CONSTRAINT; Schema: public; Owner: cnc_helper_user
--

ALTER TABLE ONLY public.authtoken_token
    ADD CONSTRAINT authtoken_token_user_id_key UNIQUE (user_id);


--
-- Name: cnc_activity_machine cnc_activity_machine_pkey; Type: CONSTRAINT; Schema: public; Owner: cnc_helper_user
--

ALTER TABLE ONLY public.cnc_activity_machine
    ADD CONSTRAINT cnc_activity_machine_pkey PRIMARY KEY (inventory_number);


--
-- Name: cnc_activity_machine_supervisors cnc_activity_machine_sup_machine_id_user_id_833ed88b_uniq; Type: CONSTRAINT; Schema: public; Owner: cnc_helper_user
--

ALTER TABLE ONLY public.cnc_activity_machine_supervisors
    ADD CONSTRAINT cnc_activity_machine_sup_machine_id_user_id_833ed88b_uniq UNIQUE (machine_id, user_id);


--
-- Name: cnc_activity_machine_supervisors cnc_activity_machine_supervisors_pkey; Type: CONSTRAINT; Schema: public; Owner: cnc_helper_user
--

ALTER TABLE ONLY public.cnc_activity_machine_supervisors
    ADD CONSTRAINT cnc_activity_machine_supervisors_pkey PRIMARY KEY (id);


--
-- Name: cnc_activity_machine_workers cnc_activity_machine_workers_machine_id_user_id_855baa09_uniq; Type: CONSTRAINT; Schema: public; Owner: cnc_helper_user
--

ALTER TABLE ONLY public.cnc_activity_machine_workers
    ADD CONSTRAINT cnc_activity_machine_workers_machine_id_user_id_855baa09_uniq UNIQUE (machine_id, user_id);


--
-- Name: cnc_activity_machine_workers cnc_activity_machine_workers_pkey; Type: CONSTRAINT; Schema: public; Owner: cnc_helper_user
--

ALTER TABLE ONLY public.cnc_activity_machine_workers
    ADD CONSTRAINT cnc_activity_machine_workers_pkey PRIMARY KEY (id);


--
-- Name: cnc_activity_machinelog_readers cnc_activity_machinelog__machinelog_id_user_id_c3595385_uniq; Type: CONSTRAINT; Schema: public; Owner: cnc_helper_user
--

ALTER TABLE ONLY public.cnc_activity_machinelog_readers
    ADD CONSTRAINT cnc_activity_machinelog__machinelog_id_user_id_c3595385_uniq UNIQUE (machinelog_id, user_id);


--
-- Name: cnc_activity_machinelog cnc_activity_machinelog_pkey; Type: CONSTRAINT; Schema: public; Owner: cnc_helper_user
--

ALTER TABLE ONLY public.cnc_activity_machinelog
    ADD CONSTRAINT cnc_activity_machinelog_pkey PRIMARY KEY (id);


--
-- Name: cnc_activity_machinelog_readers cnc_activity_machinelog_readers_pkey; Type: CONSTRAINT; Schema: public; Owner: cnc_helper_user
--

ALTER TABLE ONLY public.cnc_activity_machinelog_readers
    ADD CONSTRAINT cnc_activity_machinelog_readers_pkey PRIMARY KEY (id);


--
-- Name: django_admin_log django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: cnc_helper_user
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_content_type django_content_type_app_label_model_76bd3d3b_uniq; Type: CONSTRAINT; Schema: public; Owner: cnc_helper_user
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- Name: django_content_type django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: cnc_helper_user
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_migrations django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: cnc_helper_user
--

ALTER TABLE ONLY public.django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- Name: django_session django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: cnc_helper_user
--

ALTER TABLE ONLY public.django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: user_profile_emailconfirmation user_profile_emailconfirmation_pkey; Type: CONSTRAINT; Schema: public; Owner: cnc_helper_user
--

ALTER TABLE ONLY public.user_profile_emailconfirmation
    ADD CONSTRAINT user_profile_emailconfirmation_pkey PRIMARY KEY (uuid);


--
-- Name: user_profile_user user_profile_user_email_key; Type: CONSTRAINT; Schema: public; Owner: cnc_helper_user
--

ALTER TABLE ONLY public.user_profile_user
    ADD CONSTRAINT user_profile_user_email_key UNIQUE (email);


--
-- Name: user_profile_user_groups user_profile_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: cnc_helper_user
--

ALTER TABLE ONLY public.user_profile_user_groups
    ADD CONSTRAINT user_profile_user_groups_pkey PRIMARY KEY (id);


--
-- Name: user_profile_user_groups user_profile_user_groups_user_id_group_id_b5ee7138_uniq; Type: CONSTRAINT; Schema: public; Owner: cnc_helper_user
--

ALTER TABLE ONLY public.user_profile_user_groups
    ADD CONSTRAINT user_profile_user_groups_user_id_group_id_b5ee7138_uniq UNIQUE (user_id, group_id);


--
-- Name: user_profile_user user_profile_user_pkey; Type: CONSTRAINT; Schema: public; Owner: cnc_helper_user
--

ALTER TABLE ONLY public.user_profile_user
    ADD CONSTRAINT user_profile_user_pkey PRIMARY KEY (username);


--
-- Name: user_profile_user_user_permissions user_profile_user_user_p_user_id_permission_id_34bfca90_uniq; Type: CONSTRAINT; Schema: public; Owner: cnc_helper_user
--

ALTER TABLE ONLY public.user_profile_user_user_permissions
    ADD CONSTRAINT user_profile_user_user_p_user_id_permission_id_34bfca90_uniq UNIQUE (user_id, permission_id);


--
-- Name: user_profile_user_user_permissions user_profile_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: cnc_helper_user
--

ALTER TABLE ONLY public.user_profile_user_user_permissions
    ADD CONSTRAINT user_profile_user_user_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: public; Owner: cnc_helper_user
--

CREATE INDEX auth_group_name_a6ea08ec_like ON public.auth_group USING btree (name varchar_pattern_ops);


--
-- Name: auth_group_permissions_group_id_b120cbf9; Type: INDEX; Schema: public; Owner: cnc_helper_user
--

CREATE INDEX auth_group_permissions_group_id_b120cbf9 ON public.auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_permission_id_84c5c92e; Type: INDEX; Schema: public; Owner: cnc_helper_user
--

CREATE INDEX auth_group_permissions_permission_id_84c5c92e ON public.auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_content_type_id_2f476e4b; Type: INDEX; Schema: public; Owner: cnc_helper_user
--

CREATE INDEX auth_permission_content_type_id_2f476e4b ON public.auth_permission USING btree (content_type_id);


--
-- Name: authtoken_token_key_10f0b77e_like; Type: INDEX; Schema: public; Owner: cnc_helper_user
--

CREATE INDEX authtoken_token_key_10f0b77e_like ON public.authtoken_token USING btree (key varchar_pattern_ops);


--
-- Name: authtoken_token_user_id_35299eff_like; Type: INDEX; Schema: public; Owner: cnc_helper_user
--

CREATE INDEX authtoken_token_user_id_35299eff_like ON public.authtoken_token USING btree (user_id varchar_pattern_ops);


--
-- Name: cnc_activity_machine_inventory_number_e7e7cacc_like; Type: INDEX; Schema: public; Owner: cnc_helper_user
--

CREATE INDEX cnc_activity_machine_inventory_number_e7e7cacc_like ON public.cnc_activity_machine USING btree (inventory_number varchar_pattern_ops);


--
-- Name: cnc_activity_machine_supervisors_machine_id_01e5a885; Type: INDEX; Schema: public; Owner: cnc_helper_user
--

CREATE INDEX cnc_activity_machine_supervisors_machine_id_01e5a885 ON public.cnc_activity_machine_supervisors USING btree (machine_id);


--
-- Name: cnc_activity_machine_supervisors_machine_id_01e5a885_like; Type: INDEX; Schema: public; Owner: cnc_helper_user
--

CREATE INDEX cnc_activity_machine_supervisors_machine_id_01e5a885_like ON public.cnc_activity_machine_supervisors USING btree (machine_id varchar_pattern_ops);


--
-- Name: cnc_activity_machine_supervisors_user_id_df78fc29; Type: INDEX; Schema: public; Owner: cnc_helper_user
--

CREATE INDEX cnc_activity_machine_supervisors_user_id_df78fc29 ON public.cnc_activity_machine_supervisors USING btree (user_id);


--
-- Name: cnc_activity_machine_supervisors_user_id_df78fc29_like; Type: INDEX; Schema: public; Owner: cnc_helper_user
--

CREATE INDEX cnc_activity_machine_supervisors_user_id_df78fc29_like ON public.cnc_activity_machine_supervisors USING btree (user_id varchar_pattern_ops);


--
-- Name: cnc_activity_machine_workers_machine_id_af981bb9; Type: INDEX; Schema: public; Owner: cnc_helper_user
--

CREATE INDEX cnc_activity_machine_workers_machine_id_af981bb9 ON public.cnc_activity_machine_workers USING btree (machine_id);


--
-- Name: cnc_activity_machine_workers_machine_id_af981bb9_like; Type: INDEX; Schema: public; Owner: cnc_helper_user
--

CREATE INDEX cnc_activity_machine_workers_machine_id_af981bb9_like ON public.cnc_activity_machine_workers USING btree (machine_id varchar_pattern_ops);


--
-- Name: cnc_activity_machine_workers_user_id_c30141f0; Type: INDEX; Schema: public; Owner: cnc_helper_user
--

CREATE INDEX cnc_activity_machine_workers_user_id_c30141f0 ON public.cnc_activity_machine_workers USING btree (user_id);


--
-- Name: cnc_activity_machine_workers_user_id_c30141f0_like; Type: INDEX; Schema: public; Owner: cnc_helper_user
--

CREATE INDEX cnc_activity_machine_workers_user_id_c30141f0_like ON public.cnc_activity_machine_workers USING btree (user_id varchar_pattern_ops);


--
-- Name: cnc_activity_machinelog_bench_id_a90d1512; Type: INDEX; Schema: public; Owner: cnc_helper_user
--

CREATE INDEX cnc_activity_machinelog_bench_id_a90d1512 ON public.cnc_activity_machinelog USING btree (bench_id);


--
-- Name: cnc_activity_machinelog_bench_id_a90d1512_like; Type: INDEX; Schema: public; Owner: cnc_helper_user
--

CREATE INDEX cnc_activity_machinelog_bench_id_a90d1512_like ON public.cnc_activity_machinelog USING btree (bench_id varchar_pattern_ops);


--
-- Name: cnc_activity_machinelog_readers_machinelog_id_c78a091e; Type: INDEX; Schema: public; Owner: cnc_helper_user
--

CREATE INDEX cnc_activity_machinelog_readers_machinelog_id_c78a091e ON public.cnc_activity_machinelog_readers USING btree (machinelog_id);


--
-- Name: cnc_activity_machinelog_readers_user_id_9ba9ca7d; Type: INDEX; Schema: public; Owner: cnc_helper_user
--

CREATE INDEX cnc_activity_machinelog_readers_user_id_9ba9ca7d ON public.cnc_activity_machinelog_readers USING btree (user_id);


--
-- Name: cnc_activity_machinelog_readers_user_id_9ba9ca7d_like; Type: INDEX; Schema: public; Owner: cnc_helper_user
--

CREATE INDEX cnc_activity_machinelog_readers_user_id_9ba9ca7d_like ON public.cnc_activity_machinelog_readers USING btree (user_id varchar_pattern_ops);


--
-- Name: cnc_activity_machinelog_worked_now_id_74a47d93; Type: INDEX; Schema: public; Owner: cnc_helper_user
--

CREATE INDEX cnc_activity_machinelog_worked_now_id_74a47d93 ON public.cnc_activity_machinelog USING btree (worked_now_id);


--
-- Name: cnc_activity_machinelog_worked_now_id_74a47d93_like; Type: INDEX; Schema: public; Owner: cnc_helper_user
--

CREATE INDEX cnc_activity_machinelog_worked_now_id_74a47d93_like ON public.cnc_activity_machinelog USING btree (worked_now_id varchar_pattern_ops);


--
-- Name: django_admin_log_content_type_id_c4bce8eb; Type: INDEX; Schema: public; Owner: cnc_helper_user
--

CREATE INDEX django_admin_log_content_type_id_c4bce8eb ON public.django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_user_id_c564eba6; Type: INDEX; Schema: public; Owner: cnc_helper_user
--

CREATE INDEX django_admin_log_user_id_c564eba6 ON public.django_admin_log USING btree (user_id);


--
-- Name: django_admin_log_user_id_c564eba6_like; Type: INDEX; Schema: public; Owner: cnc_helper_user
--

CREATE INDEX django_admin_log_user_id_c564eba6_like ON public.django_admin_log USING btree (user_id varchar_pattern_ops);


--
-- Name: django_session_expire_date_a5c62663; Type: INDEX; Schema: public; Owner: cnc_helper_user
--

CREATE INDEX django_session_expire_date_a5c62663 ON public.django_session USING btree (expire_date);


--
-- Name: django_session_session_key_c0390e0f_like; Type: INDEX; Schema: public; Owner: cnc_helper_user
--

CREATE INDEX django_session_session_key_c0390e0f_like ON public.django_session USING btree (session_key varchar_pattern_ops);


--
-- Name: user_profile_emailconfirmation_user_id_24785fdb; Type: INDEX; Schema: public; Owner: cnc_helper_user
--

CREATE INDEX user_profile_emailconfirmation_user_id_24785fdb ON public.user_profile_emailconfirmation USING btree (user_id);


--
-- Name: user_profile_emailconfirmation_user_id_24785fdb_like; Type: INDEX; Schema: public; Owner: cnc_helper_user
--

CREATE INDEX user_profile_emailconfirmation_user_id_24785fdb_like ON public.user_profile_emailconfirmation USING btree (user_id varchar_pattern_ops);


--
-- Name: user_profile_user_email_5b95ca4b_like; Type: INDEX; Schema: public; Owner: cnc_helper_user
--

CREATE INDEX user_profile_user_email_5b95ca4b_like ON public.user_profile_user USING btree (email varchar_pattern_ops);


--
-- Name: user_profile_user_groups_group_id_7cd4b3f5; Type: INDEX; Schema: public; Owner: cnc_helper_user
--

CREATE INDEX user_profile_user_groups_group_id_7cd4b3f5 ON public.user_profile_user_groups USING btree (group_id);


--
-- Name: user_profile_user_groups_user_id_cefab937; Type: INDEX; Schema: public; Owner: cnc_helper_user
--

CREATE INDEX user_profile_user_groups_user_id_cefab937 ON public.user_profile_user_groups USING btree (user_id);


--
-- Name: user_profile_user_groups_user_id_cefab937_like; Type: INDEX; Schema: public; Owner: cnc_helper_user
--

CREATE INDEX user_profile_user_groups_user_id_cefab937_like ON public.user_profile_user_groups USING btree (user_id varchar_pattern_ops);


--
-- Name: user_profile_user_user_permissions_permission_id_fcfd8bc0; Type: INDEX; Schema: public; Owner: cnc_helper_user
--

CREATE INDEX user_profile_user_user_permissions_permission_id_fcfd8bc0 ON public.user_profile_user_user_permissions USING btree (permission_id);


--
-- Name: user_profile_user_user_permissions_user_id_bdd85bfb; Type: INDEX; Schema: public; Owner: cnc_helper_user
--

CREATE INDEX user_profile_user_user_permissions_user_id_bdd85bfb ON public.user_profile_user_user_permissions USING btree (user_id);


--
-- Name: user_profile_user_user_permissions_user_id_bdd85bfb_like; Type: INDEX; Schema: public; Owner: cnc_helper_user
--

CREATE INDEX user_profile_user_user_permissions_user_id_bdd85bfb_like ON public.user_profile_user_user_permissions USING btree (user_id varchar_pattern_ops);


--
-- Name: user_profile_user_username_35ac9403_like; Type: INDEX; Schema: public; Owner: cnc_helper_user
--

CREATE INDEX user_profile_user_username_35ac9403_like ON public.user_profile_user USING btree (username varchar_pattern_ops);


--
-- Name: auth_group_permissions auth_group_permissio_permission_id_84c5c92e_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: cnc_helper_user
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: cnc_helper_user
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_permission auth_permission_content_type_id_2f476e4b_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: cnc_helper_user
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: authtoken_token authtoken_token_user_id_35299eff_fk_user_profile_user_username; Type: FK CONSTRAINT; Schema: public; Owner: cnc_helper_user
--

ALTER TABLE ONLY public.authtoken_token
    ADD CONSTRAINT authtoken_token_user_id_35299eff_fk_user_profile_user_username FOREIGN KEY (user_id) REFERENCES public.user_profile_user(username) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: cnc_activity_machinelog cnc_activity_machine_bench_id_a90d1512_fk_cnc_activ; Type: FK CONSTRAINT; Schema: public; Owner: cnc_helper_user
--

ALTER TABLE ONLY public.cnc_activity_machinelog
    ADD CONSTRAINT cnc_activity_machine_bench_id_a90d1512_fk_cnc_activ FOREIGN KEY (bench_id) REFERENCES public.cnc_activity_machine(inventory_number) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: cnc_activity_machine_supervisors cnc_activity_machine_machine_id_01e5a885_fk_cnc_activ; Type: FK CONSTRAINT; Schema: public; Owner: cnc_helper_user
--

ALTER TABLE ONLY public.cnc_activity_machine_supervisors
    ADD CONSTRAINT cnc_activity_machine_machine_id_01e5a885_fk_cnc_activ FOREIGN KEY (machine_id) REFERENCES public.cnc_activity_machine(inventory_number) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: cnc_activity_machine_workers cnc_activity_machine_machine_id_af981bb9_fk_cnc_activ; Type: FK CONSTRAINT; Schema: public; Owner: cnc_helper_user
--

ALTER TABLE ONLY public.cnc_activity_machine_workers
    ADD CONSTRAINT cnc_activity_machine_machine_id_af981bb9_fk_cnc_activ FOREIGN KEY (machine_id) REFERENCES public.cnc_activity_machine(inventory_number) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: cnc_activity_machinelog_readers cnc_activity_machine_machinelog_id_c78a091e_fk_cnc_activ; Type: FK CONSTRAINT; Schema: public; Owner: cnc_helper_user
--

ALTER TABLE ONLY public.cnc_activity_machinelog_readers
    ADD CONSTRAINT cnc_activity_machine_machinelog_id_c78a091e_fk_cnc_activ FOREIGN KEY (machinelog_id) REFERENCES public.cnc_activity_machinelog(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: cnc_activity_machinelog_readers cnc_activity_machine_user_id_9ba9ca7d_fk_user_prof; Type: FK CONSTRAINT; Schema: public; Owner: cnc_helper_user
--

ALTER TABLE ONLY public.cnc_activity_machinelog_readers
    ADD CONSTRAINT cnc_activity_machine_user_id_9ba9ca7d_fk_user_prof FOREIGN KEY (user_id) REFERENCES public.user_profile_user(username) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: cnc_activity_machine_workers cnc_activity_machine_user_id_c30141f0_fk_user_prof; Type: FK CONSTRAINT; Schema: public; Owner: cnc_helper_user
--

ALTER TABLE ONLY public.cnc_activity_machine_workers
    ADD CONSTRAINT cnc_activity_machine_user_id_c30141f0_fk_user_prof FOREIGN KEY (user_id) REFERENCES public.user_profile_user(username) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: cnc_activity_machine_supervisors cnc_activity_machine_user_id_df78fc29_fk_user_prof; Type: FK CONSTRAINT; Schema: public; Owner: cnc_helper_user
--

ALTER TABLE ONLY public.cnc_activity_machine_supervisors
    ADD CONSTRAINT cnc_activity_machine_user_id_df78fc29_fk_user_prof FOREIGN KEY (user_id) REFERENCES public.user_profile_user(username) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: cnc_activity_machinelog cnc_activity_machine_worked_now_id_74a47d93_fk_user_prof; Type: FK CONSTRAINT; Schema: public; Owner: cnc_helper_user
--

ALTER TABLE ONLY public.cnc_activity_machinelog
    ADD CONSTRAINT cnc_activity_machine_worked_now_id_74a47d93_fk_user_prof FOREIGN KEY (worked_now_id) REFERENCES public.user_profile_user(username) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_content_type_id_c4bce8eb_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: cnc_helper_user
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_user_id_c564eba6_fk_user_profile_user_username; Type: FK CONSTRAINT; Schema: public; Owner: cnc_helper_user
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_user_profile_user_username FOREIGN KEY (user_id) REFERENCES public.user_profile_user(username) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: user_profile_emailconfirmation user_profile_emailco_user_id_24785fdb_fk_user_prof; Type: FK CONSTRAINT; Schema: public; Owner: cnc_helper_user
--

ALTER TABLE ONLY public.user_profile_emailconfirmation
    ADD CONSTRAINT user_profile_emailco_user_id_24785fdb_fk_user_prof FOREIGN KEY (user_id) REFERENCES public.user_profile_user(username) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: user_profile_user_groups user_profile_user_gr_user_id_cefab937_fk_user_prof; Type: FK CONSTRAINT; Schema: public; Owner: cnc_helper_user
--

ALTER TABLE ONLY public.user_profile_user_groups
    ADD CONSTRAINT user_profile_user_gr_user_id_cefab937_fk_user_prof FOREIGN KEY (user_id) REFERENCES public.user_profile_user(username) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: user_profile_user_groups user_profile_user_groups_group_id_7cd4b3f5_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: cnc_helper_user
--

ALTER TABLE ONLY public.user_profile_user_groups
    ADD CONSTRAINT user_profile_user_groups_group_id_7cd4b3f5_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: user_profile_user_user_permissions user_profile_user_us_permission_id_fcfd8bc0_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: cnc_helper_user
--

ALTER TABLE ONLY public.user_profile_user_user_permissions
    ADD CONSTRAINT user_profile_user_us_permission_id_fcfd8bc0_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: user_profile_user_user_permissions user_profile_user_us_user_id_bdd85bfb_fk_user_prof; Type: FK CONSTRAINT; Schema: public; Owner: cnc_helper_user
--

ALTER TABLE ONLY public.user_profile_user_user_permissions
    ADD CONSTRAINT user_profile_user_us_user_id_bdd85bfb_fk_user_prof FOREIGN KEY (user_id) REFERENCES public.user_profile_user(username) DEFERRABLE INITIALLY DEFERRED;


--
-- PostgreSQL database dump complete
--

